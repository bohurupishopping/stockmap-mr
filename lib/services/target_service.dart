import 'dart:developer';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/target_models.dart';
import '../models/order_models.dart';

class TargetService {
  static final _supabase = Supabase.instance.client;

  /// Get dashboard data for the specified period
  static Future<DashboardData> getDashboardData(String period) async {
    try {
      log('TargetService: Starting getDashboardData for period: $period');
      
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        log('TargetService: User not authenticated');
        throw Exception('User not authenticated');
      }

      final dateRange = _getPeriodDateRange(period);
      log('TargetService: Date range: ${dateRange['start']} to ${dateRange['end']}');

      // Get target for the period
      final target = await _getTargetForPeriod(userId, dateRange['start']!, dateRange['end']!);
      
      // Get sales data for the period
      final salesData = await _getSalesDataForPeriod(userId, dateRange['start']!, dateRange['end']!);
      
      // Get focus goal progress if target has focus goals
      ProductGoalProgress? focusProgress;
      if (target?.productSpecificGoals != null) {
        focusProgress = await _getFocusGoalProgress(userId, target!.productSpecificGoals!, dateRange['start']!, dateRange['end']!);
      }

      return DashboardData(
        target: target,
        totalSalesAmount: salesData['totalSales'] ?? 0.0,
        totalCollectedAmount: salesData['totalCollected'] ?? 0.0,
        recentSales: salesData['recentSales'] ?? [],
        focusGoalProgress: focusProgress,
      );
    } catch (e) {
      log('TargetService: Error in getDashboardData: $e');
      rethrow;
    }
  }

  /// Create or update a sales target
  static Future<MrSalesTarget> createTarget(TargetFormData formData, String period) async {
    try {
      log('TargetService: Creating target for period: $period');
      
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final dateRange = _getPeriodDateRange(period);
      final periodType = _getPeriodType(period);
      final startDateStr = dateRange['start']!.toIso8601String().split('T')[0];

      Map<String, dynamic>? productGoals;
      if (formData.focusProductId != null && formData.focusProductId!.isNotEmpty) {
        productGoals = {
          'type': formData.focusType,
          'id': formData.focusProductId!,
          'goal_units': formData.focusGoalUnits,
          'goal_amount': formData.focusGoalAmount,
          'product_name': formData.focusProductName ?? 'Unknown Product',
        };
      }

      // Check if target already exists for this period
      final existingTarget = await _supabase
          .from('mr_sales_targets')
          .select('id')
          .eq('mr_user_id', userId)
          .eq('start_date', startDateStr)
          .maybeSingle();

      // Map to exact database enum values
      final formattedPeriodType = switch (periodType) {
        TargetPeriodType.monthly => 'Monthly',
        TargetPeriodType.quarterly => 'Quarterly',
        TargetPeriodType.yearly => 'Yearly',
      };
      
      final targetData = {
        'mr_user_id': userId,
        'period_type': formattedPeriodType,
        'start_date': startDateStr,
        'end_date': dateRange['end']!.toIso8601String().split('T')[0],
        'target_sales_amount': formData.mainGoal,
        'target_tier_bronze': formData.bronzeGoal > 0 ? formData.bronzeGoal : null,
        'target_tier_gold': formData.goldGoal > 0 ? formData.goldGoal : null,
        'product_specific_goals': productGoals,
        'target_collection_percentage': formData.collectionPercentage > 0 ? formData.collectionPercentage : null,
        'updated_at': DateTime.now().toIso8601String(),
      };

      dynamic response;
      if (existingTarget != null) {
        // Update existing target
        log('TargetService: Updating existing target');
        response = await _supabase
            .from('mr_sales_targets')
            .update(targetData)
            .eq('id', existingTarget['id'])
            .select()
            .single();
      } else {
        // Insert new target
        log('TargetService: Creating new target');
        response = await _supabase
            .from('mr_sales_targets')
            .insert(targetData)
            .select()
            .single();
      }

      log('TargetService: Target created/updated successfully');
      return MrSalesTarget.fromJson(response);
    } catch (e) {
      log('TargetService: Error creating target: $e');
      rethrow;
    }
  }

  /// Get target for a specific period
  static Future<MrSalesTarget?> _getTargetForPeriod(String userId, DateTime startDate, DateTime endDate) async {
    try {
      final response = await _supabase
          .from('mr_sales_targets')
          .select()
          .eq('mr_user_id', userId)
          .eq('start_date', startDate.toIso8601String().split('T')[0])
          .maybeSingle();

      if (response == null) return null;
      
      return MrSalesTarget.fromJson(response);
    } catch (e) {
      log('TargetService: Error getting target: $e');
      return null;
    }
  }

  /// Get sales data for a specific period
  static Future<Map<String, dynamic>> _getSalesDataForPeriod(String userId, DateTime startDate, DateTime endDate) async {
    try {
      final response = await _supabase
          .from('mr_sales_orders')
          .select('''
            id,
            mr_user_id,
            customer_name,
            order_date,
            total_amount,
            payment_status,
            notes,
            created_at,
            updated_at
          ''')
          .eq('mr_user_id', userId)
          .gte('order_date', startDate.toIso8601String().split('T')[0])
          .lte('order_date', endDate.toIso8601String().split('T')[0])
          .order('order_date', ascending: false);

      final orders = response.map((order) => MrSalesOrder.fromJson(order)).toList();
      
      double totalSales = 0.0;
      double totalCollected = 0.0;
      
      for (final order in orders) {
        totalSales += order.totalAmount;
        if (order.paymentStatus == PaymentStatus.paid) {
          totalCollected += order.totalAmount;
        }
      }

      return {
        'totalSales': totalSales,
        'totalCollected': totalCollected,
        'recentSales': orders,
      };
    } catch (e) {
      log('TargetService: Error getting sales data: $e');
      return {
        'totalSales': 0.0,
        'totalCollected': 0.0,
        'recentSales': <MrSalesOrder>[],
      };
    }
  }

  /// Get focus goal progress
  static Future<ProductGoalProgress?> _getFocusGoalProgress(String userId, Map<String, dynamic> productGoals, DateTime startDate, DateTime endDate) async {
    try {
      if (productGoals['type'] != 'product' || productGoals['id'] == null) {
        return null;
      }

      final response = await _supabase
          .from('mr_sales_order_items')
          .select('''
            quantity_strips_sold,
            line_item_total,
            mr_sales_orders!inner(
              order_date,
              mr_user_id
            )
          ''')
          .eq('product_id', productGoals['id'])
          .eq('mr_sales_orders.mr_user_id', userId)
          .gte('mr_sales_orders.order_date', startDate.toIso8601String().split('T')[0])
          .lte('mr_sales_orders.order_date', endDate.toIso8601String().split('T')[0]);

      int totalUnits = 0;
      double totalAmount = 0.0;
      
      for (final item in response) {
        totalUnits += (item['quantity_strips_sold'] as int? ?? 0);
        totalAmount += (item['line_item_total'] as double? ?? 0.0);
      }

      return ProductGoalProgress(
        productName: productGoals['product_name'] ?? 'Product',
        currentUnits: totalUnits,
        targetUnits: productGoals['goal_units'] ?? 0,
        currentAmount: totalAmount,
        targetAmount: productGoals['goal_amount']?.toDouble(),
      );
    } catch (e) {
      log('TargetService: Error getting focus goal progress: $e');
      return null;
    }
  }

  /// Get date range for period
  static Map<String, DateTime> _getPeriodDateRange(String period) {
    final now = DateTime.now();
    
    switch (period.toLowerCase()) {
      case 'this month':
        return {
          'start': DateTime(now.year, now.month, 1),
          'end': DateTime(now.year, now.month + 1, 0),
        };
      case 'last month':
        final lastMonth = DateTime(now.year, now.month - 1, 1);
        return {
          'start': lastMonth,
          'end': DateTime(lastMonth.year, lastMonth.month + 1, 0),
        };
      case 'this quarter':
        final quarterStart = DateTime(now.year, ((now.month - 1) ~/ 3) * 3 + 1, 1);
        final quarterEnd = DateTime(quarterStart.year, quarterStart.month + 3, 0);
        return {
          'start': quarterStart,
          'end': quarterEnd,
        };
      default:
        return {
          'start': DateTime(now.year, now.month, 1),
          'end': DateTime(now.year, now.month + 1, 0),
        };
    }
  }

  /// Get period type enum
  static TargetPeriodType _getPeriodType(String period) {
    switch (period.toLowerCase()) {
      case 'this month':
      case 'last month':
        return TargetPeriodType.monthly;
      case 'this quarter':
        return TargetPeriodType.quarterly;
      default:
        return TargetPeriodType.monthly;
    }
  }

  /// Get available products for focus goals
  static Future<List<Map<String, dynamic>>> getAvailableProducts() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final response = await _supabase
          .from('mr_stock_summary')
          .select('''
            product_id,
            products!inner(
              product_name,
              manufacturer
            )
          ''')
          .eq('mr_user_id', userId)
          .gt('current_quantity_strips', 0);

      final uniqueProducts = <String, Map<String, dynamic>>{};
      
      for (final item in response) {
        final productId = item['product_id'] as String;
        if (!uniqueProducts.containsKey(productId)) {
          uniqueProducts[productId] = {
            'id': productId,
            'name': item['products']['product_name'],
            'manufacturer': item['products']['manufacturer'],
          };
        }
      }

      return uniqueProducts.values.toList();
    } catch (e) {
      log('TargetService: Error getting available products: $e');
      return [];
    }
  }
}
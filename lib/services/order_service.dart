import 'dart:developer';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/order_models.dart';

class OrderService {
  static final _supabase = Supabase.instance.client;

  /// Fetch MR stock summary for the logged-in MR
  static Future<List<MrStockItem>> getMrStock() async {
    try {
      log('OrderService: Starting getMrStock()');
      
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        log('OrderService: User not authenticated');
        throw Exception('User not authenticated');
      }
      
      log('OrderService: User ID: $userId');

      // First, get the basic stock data
      log('OrderService: Fetching stock data from mr_stock_summary');
      final stockResponse = await _supabase
          .from('mr_stock_summary')
          .select('''
            mr_user_id,
            product_id,
            batch_id,
            current_quantity_strips,
            price_per_strip,
            last_updated_at,
            products!inner(
              product_name,
              manufacturer,
              generic_name,
              packaging_template
            ),
            product_batches!inner(
              batch_number,
              expiry_date
            )
          ''')
          .eq('mr_user_id', userId)
          .gt('current_quantity_strips', 0)
          .order('product_name', referencedTable: 'products');

      log('OrderService: Stock response received: ${stockResponse.length} items');
      log('OrderService: Stock response data: $stockResponse');

      if (stockResponse.isEmpty) {
        log('OrderService: No stock found for user');
        return [];
      }

      // Get packaging data for all products
      final productIds = stockResponse
          .map((item) => item['product_id'] as String)
          .toSet()
          .toList();

      log('OrderService: Fetching packaging data for ${productIds.length} products');
      final packagingResponse = await _supabase
          .from('product_packaging_units')
          .select('product_id, unit_name, conversion_factor_to_strips')
          .inFilter('product_id', productIds);

      log('OrderService: Packaging response: $packagingResponse');

      // Create packaging map
      final packagingMap = <String, Map<String, double>>{};
      for (final packaging in packagingResponse) {
        final productId = packaging['product_id'] as String;
        final unitName = packaging['unit_name'] as String;
        final conversionFactorValue = packaging['conversion_factor_to_strips'];
        
        // Skip if conversion factor is null
        if (conversionFactorValue == null) {
          log('OrderService: Skipping packaging unit $unitName for product $productId - null conversion factor');
          continue;
        }
        
        final conversionFactor = (conversionFactorValue as num).toDouble();
        
        if (!packagingMap.containsKey(productId)) {
          packagingMap[productId] = {};
        }
        packagingMap[productId]![unitName] = conversionFactor;
      }

      // Map the response to MrStockItem objects
      final stockItems = stockResponse.map((item) {
        return _mapStockResponse(item, packagingMap);
      }).toList();

      log('OrderService: Successfully mapped ${stockItems.length} stock items');
      return stockItems;
    } catch (e) {
      log('OrderService: Error in getMrStock: $e');
      throw Exception('Failed to fetch stock: $e');
    }
  }

  /// Fetch orders for the current MR user
  static Future<List<MrSalesOrder>> getMrOrders() async {
    try {
      log('OrderService: Starting getMrOrders()');
      
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        log('OrderService: User not authenticated');
        throw Exception('User not authenticated');
      }
      
      log('OrderService: User ID: $userId');

      // Fetch orders with items
      final ordersResponse = await _supabase
          .from('mr_sales_orders')
          .select('''
            *,
            mr_sales_order_items(
              *,
              products(
                product_name
              ),
              product_batches(
                batch_number,
                expiry_date
              )
            )
          ''')
          .eq('mr_user_id', userId)
          .order('order_date', ascending: false);

      log('OrderService: Orders response received: ${ordersResponse.length} orders');

      final orders = <MrSalesOrder>[];
      
      for (final orderData in ordersResponse) {
        try {
          // Process order items
          final items = <MrSalesOrderItem>[];
          final orderItems = orderData['mr_sales_order_items'] as List? ?? [];
          
          for (final itemData in orderItems) {
            final product = itemData['products'] as Map<String, dynamic>?;
            final batch = itemData['product_batches'] as Map<String, dynamic>?;
            
            final item = MrSalesOrderItem(
              id: itemData['id'] ?? '',
              orderId: itemData['order_id'] ?? '',
              productId: itemData['product_id'] ?? '',
              batchId: itemData['batch_id'] ?? '',
              quantityStripsSold: (itemData['quantity_strips_sold'] ?? 0).toInt(),
              pricePerStrip: (itemData['price_per_strip'] ?? 0.0).toDouble(),
              lineItemTotal: (itemData['line_item_total'] ?? 0.0).toDouble(),
              createdAt: DateTime.parse(itemData['created_at'] ?? DateTime.now().toIso8601String()),
              productName: product?['product_name'],
              batchNumber: batch?['batch_number'],
              expiryDate: batch?['expiry_date'] != null 
                  ? DateTime.parse(batch!['expiry_date']) 
                  : null,
            );
            
            items.add(item);
          }
          
          // Parse payment status
          PaymentStatus paymentStatus;
          switch (orderData['payment_status']?.toString().toLowerCase()) {
            case 'paid':
              paymentStatus = PaymentStatus.paid;
              break;
            case 'partial':
              paymentStatus = PaymentStatus.partial;
              break;
            default:
              paymentStatus = PaymentStatus.pending;
              break;
          }
          
          final order = MrSalesOrder(
            id: orderData['id'] ?? '',
            mrUserId: orderData['mr_user_id'] ?? '',
            customerName: orderData['customer_name'] ?? '',
            orderDate: DateTime.parse(orderData['order_date'] ?? DateTime.now().toIso8601String()),
            totalAmount: (orderData['total_amount'] ?? 0.0).toDouble(),
            paymentStatus: paymentStatus,
            notes: orderData['notes'],
            createdAt: DateTime.parse(orderData['created_at'] ?? DateTime.now().toIso8601String()),
            updatedAt: DateTime.parse(orderData['updated_at'] ?? DateTime.now().toIso8601String()),
            items: items,
          );
          
          orders.add(order);
        } catch (e) {
          log('OrderService: Error processing order ${orderData['id']}: $e');
          // Continue processing other orders
        }
      }
      
      log('OrderService: Successfully processed ${orders.length} orders');
      return orders;
    } catch (e) {
      log('OrderService: Error in getMrOrders: $e');
      throw Exception('Failed to fetch orders: $e');
    }
  }



  /// Helper method to map stock response to MrStockItem
  static MrStockItem _mapStockResponse(
    Map<String, dynamic> item,
    Map<String, Map<String, double>> packagingMap,
  ) {
    try {
      final product = item['products'] as Map<String, dynamic>;
      final batch = item['product_batches'] as Map<String, dynamic>;
      final productId = item['product_id'] as String;
      
      // Get packaging info for this product
      
      return MrStockItem.fromJson({
        'productId': productId,
        'batchId': item['batch_id'],
        'productName': product['product_name'],
        'batchNumber': batch['batch_number'],
        'expiryDate': batch['expiry_date'],
        'currentQuantityStrips': item['current_quantity_strips'] ?? 0,
        'pricePerStrip': (item['price_per_strip'] ?? 0.0).toDouble(),
        'stripsPerBox': 1, // Default value, should be from product data
        'boxesPerCarton': 1, // Default value, should be from product data
        'manufacturer': product['manufacturer'],
        'genericName': product['generic_name'],
      });
    } catch (e) {
      log('OrderService: Error mapping stock item: $e');
      log('OrderService: Item data: $item');
      rethrow;
    }
  }




}
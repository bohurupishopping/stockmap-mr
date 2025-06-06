import 'dart:developer';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/order_models.dart';
import 'order_service.dart';

class OrderCreationService {
  static final _supabase = Supabase.instance.client;

  /// Create a new MR sales order
  static Future<String> createMrSalesOrder({
    required String customerName,
    required List<CartItem> items,
    String? notes,
  }) async {
    try {
      log('OrderCreationService: Starting createMrSalesOrder');
      
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        log('OrderCreationService: User not authenticated');
        throw Exception('User not authenticated');
      }

      if (items.isEmpty) {
        throw Exception('Cannot create order with no items');
      }

      // Calculate total amount
      final totalAmount = items.fold<double>(
        0.0,
        (sum, item) => sum + (item.pricePerStrip * item.quantityStrips),
      );

      log('OrderCreationService: Creating order for user $userId with ${items.length} items, total: $totalAmount');

      // Prepare items for the RPC call
      final itemsData = items.map((item) => {
        'product_id': item.productId,
        'batch_id': item.batchId,
        'quantity_strips_sold': item.quantityStrips,
        'price_per_strip': item.pricePerStrip,
      }).toList();

      log('OrderCreationService: Items data: $itemsData');

      // Call the RPC function
      final response = await _supabase.rpc('create_mr_sale', params: {
        'p_customer_name': customerName,
        'p_items': itemsData,
        'p_total_amount': totalAmount,
        'p_notes': notes,
      });

      log('OrderCreationService: RPC response: $response');

      if (response == null) {
        throw Exception('Failed to create order: No response from server');
      }

      final orderId = response.toString();
      log('OrderCreationService: Order created successfully with ID: $orderId');
      
      return orderId;
    } catch (e) {
      log('OrderCreationService: Error creating order: $e');
      throw Exception('Failed to create order: $e');
    }
  }

  /// Validate stock availability for cart items
  static Future<Map<String, dynamic>> validateStockAvailability(
    List<CartItem> cartItems,
  ) async {
    try {
      log('OrderCreationService: Validating stock availability for ${cartItems.length} items');
      
      // Get stock data from OrderService
      final stockItems = await OrderService.getMrStock();
      final stockMap = <String, MrStockItem>{};
      
      // Create a map for quick lookup
      for (final stock in stockItems) {
        stockMap['${stock.productId}_${stock.batchId}'] = stock;
      }
      
      final unavailableItems = <Map<String, dynamic>>[];
      
      for (final cartItem in cartItems) {
        final key = '${cartItem.productId}_${cartItem.batchId}';
        final stockItem = stockMap[key];
        
        if (stockItem == null) {
          unavailableItems.add({
            'product_name': cartItem.productName,
            'batch_number': cartItem.batchNumber,
            'requested_quantity': cartItem.quantityStrips,
            'available_quantity': 0,
            'error': 'Product not found in stock',
          });
        } else if (cartItem.quantityStrips > stockItem.currentQuantityStrips) {
          unavailableItems.add({
            'product_name': cartItem.productName,
            'batch_number': cartItem.batchNumber,
            'requested_quantity': cartItem.quantityStrips,
            'available_quantity': stockItem.currentQuantityStrips,
            'error': 'Insufficient stock',
          });
        }
      }
      
      return {
        'is_valid': unavailableItems.isEmpty,
        'unavailable_items': unavailableItems,
      };
    } catch (e) {
      log('OrderCreationService: Error validating stock: $e');
      throw Exception('Failed to validate stock: $e');
    }
  }
  
  /// Create sales order (alias for createMrSalesOrder)
  static Future<String> createSalesOrder({
    required String customerName,
    required List<CartItem> items,
    String? notes,
  }) async {
    return createMrSalesOrder(
      customerName: customerName,
      items: items,
      notes: notes,
    );
  }
}
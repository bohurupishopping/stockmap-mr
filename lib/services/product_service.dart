import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product_models.dart';
import 'dart:async';

class ProductService {
  static final _supabase = Supabase.instance.client;
  
  // Packaging cache only (lightweight data that rarely changes)
  static final Map<String, int> _packagingCache = {};
  
  static void clearPackagingCache() {
    _packagingCache.clear();
  }

  static Future<Map<String, dynamic>> getProducts({
    ProductFilters? filters,
    int page = 1,
    int limit = 20,
    String sortField = 'product_name',
    String sortDirection = 'asc',
    bool includeStock = true,

  }) async {
    try {
      dynamic query = _supabase
          .from('products')
          .select('''
            *,
            product_categories(category_name),
            product_sub_categories(sub_category_name),
            product_formulations(formulation_name)
          ''');

      // Apply filters
      if (filters != null) {
        if (filters.searchQuery?.isNotEmpty == true) {
          query = query.or(
            'product_name.ilike.%${filters.searchQuery}%,'
            'product_code.ilike.%${filters.searchQuery}%,'
            'generic_name.ilike.%${filters.searchQuery}%,'
            'manufacturer.ilike.%${filters.searchQuery}%'
          );
        }

        if (filters.categoryId?.isNotEmpty == true) {
          query = query.eq('category_id', filters.categoryId!);
        }

        if (filters.subCategoryId?.isNotEmpty == true) {
          query = query.eq('sub_category_id', filters.subCategoryId!);
        }

        if (filters.formulationId?.isNotEmpty == true) {
          query = query.eq('formulation_id', filters.formulationId!);
        }

        if (filters.manufacturer?.isNotEmpty == true) {
          query = query.eq('manufacturer', filters.manufacturer!);
        }

        if (filters.isActive != null) {
          query = query.eq('is_active', filters.isActive!);
        }

        if (filters.minCost != null) {
          query = query.gte('base_cost_per_strip', filters.minCost!);
        }

        if (filters.maxCost != null) {
          query = query.lte('base_cost_per_strip', filters.maxCost!);
        }
      }

      // Apply sorting
      query = query.order(sortField, ascending: sortDirection == 'asc');

      // Get total count
      dynamic countQuery = _supabase
          .from('products')
          .select('*');
      
      if (filters != null) {
        if (filters.searchQuery?.isNotEmpty == true) {
          countQuery.or(
            'product_name.ilike.%${filters.searchQuery}%,'
            'product_code.ilike.%${filters.searchQuery}%,'
            'generic_name.ilike.%${filters.searchQuery}%,'
            'manufacturer.ilike.%${filters.searchQuery}%'
          );
        }
        if (filters.categoryId?.isNotEmpty == true) {
          countQuery.eq('category_id', filters.categoryId!);
        }
        if (filters.subCategoryId?.isNotEmpty == true) {
          countQuery.eq('sub_category_id', filters.subCategoryId!);
        }
        if (filters.formulationId?.isNotEmpty == true) {
          countQuery.eq('formulation_id', filters.formulationId!);
        }
        if (filters.manufacturer?.isNotEmpty == true) {
          countQuery.eq('manufacturer', filters.manufacturer!);
        }
        if (filters.isActive != null) {
          countQuery.eq('is_active', filters.isActive!);
        }
        if (filters.minCost != null) {
          countQuery.gte('base_cost_per_strip', filters.minCost!);
        }
        if (filters.maxCost != null) {
          countQuery.lte('base_cost_per_strip', filters.maxCost!);
        }
      }

      // Apply pagination
      final offset = (page - 1) * limit;
      query = query.range(offset, offset + limit - 1);

      final results = await Future.wait<dynamic>([
        query,
        countQuery,
      ]);

      final data = results[0] as List<dynamic>;
      final countData = results[1] as List<dynamic>;
      final totalCount = countData.length;

      final products = data.map((json) => Product.fromJson(json)).toList();
      
      // No cache initialization needed for live data
      
      // Fetch closing stock data for all products if requested
      if (includeStock) {
        await _enrichWithClosingStockBatch(products);
      }

      return {
        'products': products,
        'totalCount': totalCount,
        'hasMore': (page * limit) < totalCount,
      };
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  static Future<List<ProductCategory>> getCategories() async {
    try {
      final response = await _supabase
          .from('product_categories')
          .select()
          .eq('is_active', true)
          .order('category_name');

      return response.map((json) => ProductCategory.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  static Future<List<ProductSubCategory>> getSubCategories(String? categoryId) async {
    try {
      var query = _supabase
          .from('product_sub_categories')
          .select()
          .eq('is_active', true);

      if (categoryId?.isNotEmpty == true) {
        query = query.eq('category_id', categoryId!);
      }

      final response = await query.order('sub_category_name');

      return response.map((json) => ProductSubCategory.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch sub-categories: $e');
    }
  }

  static Future<List<ProductFormulation>> getFormulations() async {
    try {
      final response = await _supabase
          .from('product_formulations')
          .select()
          .eq('is_active', true)
          .order('formulation_name');

      return response.map((json) => ProductFormulation.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch formulations: $e');
    }
  }

  static Future<List<String>> getManufacturers() async {
    try {
      final response = await _supabase
          .from('products')
          .select('manufacturer')
          .eq('is_active', true)
          .order('manufacturer');

      final manufacturers = response
          .map((item) => item['manufacturer'] as String)
          .where((manufacturer) => manufacturer.isNotEmpty)
          .toSet()
          .toList();

      return manufacturers;
    } catch (e) {
      throw Exception('Failed to fetch manufacturers: $e');
    }
  }

  /// Optimized batch enrichment with live data
  static Future<void> _enrichWithClosingStockBatch(List<Product> products) async {
    try {
      if (products.isEmpty) return;
      
      final productIds = products.map((p) => p.id).toList();
      // Get packaging data with caching
      await _loadPackagingDataBatch(productIds);
      
      // Get live stock data with batch processing
      final stockDataMap = await _getLiveStockDataBatch(productIds);
      
      // Update products with calculated stock data
      for (int i = 0; i < products.length; i++) {
        final product = products[i];
        final stockData = stockDataMap[product.id] ?? {'godownStock': 0, 'mrStock': 0};
        final stripsPerBox = _packagingCache[product.id] ?? 10;
        
        // Create a new product instance with calculated stock data
        products[i] = Product(
          id: product.id,
          productCode: product.productCode,
          productName: product.productName,
          genericName: product.genericName,
          manufacturer: product.manufacturer,
          categoryId: product.categoryId,
          subCategoryId: product.subCategoryId,
          formulationId: product.formulationId,
          unitOfMeasureSmallest: product.unitOfMeasureSmallest,
          baseCostPerStrip: product.baseCostPerStrip,
          isActive: product.isActive,
          storageConditions: product.storageConditions,
          imageUrl: product.imageUrl,
          minStockLevelGodown: product.minStockLevelGodown,
          minStockLevelMr: product.minStockLevelMr,
          leadTimeDays: product.leadTimeDays,
          createdAt: product.createdAt,
          updatedAt: product.updatedAt,
          categoryName: product.categoryName,
          subCategoryName: product.subCategoryName,
          formulationName: product.formulationName,
          closingStockGodown: stockData['godownStock'] ?? 0,
          closingStockMr: stockData['mrStock'] ?? 0,
          stripsPerBox: stripsPerBox,
        );
      }
    } catch (e) {
      // If calculating stock fails, continue with default values (0)
    }
  }
  
  /// Load packaging data in batch with caching
  static Future<void> _loadPackagingDataBatch(List<String> productIds) async {
    final uncachedIds = productIds.where((id) => !_packagingCache.containsKey(id)).toList();
    
    if (uncachedIds.isNotEmpty) {
      final packagingUnits = await _supabase
          .from('product_packaging_units')
          .select('product_id, unit_name, conversion_factor_to_strips')
          .inFilter('product_id', uncachedIds)
          .eq('unit_name', 'Box');
      
      // Cache packaging data
      for (final unit in packagingUnits) {
        final productId = unit['product_id'] as String;
        final conversionFactor = (unit['conversion_factor_to_strips'] ?? 10) as int;
        _packagingCache[productId] = conversionFactor;
      }
      
      // Set default for products without packaging data
      for (final id in uncachedIds) {
        _packagingCache.putIfAbsent(id, () => 10);
      }
    }
  }
  
  /// Get live stock data in batch (no caching for real-time data)
  static Future<Map<String, Map<String, int>>> _getLiveStockDataBatch(List<String> productIds) async {
    // Always fetch fresh data from Supabase for live stock information
    return await _calculateStockDataBatch(productIds);
  }
  
  /// Batch calculate stock data for multiple products
  static Future<Map<String, Map<String, int>>> _calculateStockDataBatch(List<String> productIds) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        return {for (final id in productIds) id: {'godownStock': 0, 'mrStock': 0}};
      }
      
      // Batch fetch MR stock for all products
      final mrStockFuture = _supabase
          .from('mr_stock_summary')
          .select('product_id, current_quantity_strips')
          .inFilter('product_id', productIds)
          .eq('mr_user_id', user.id);
      
      // Batch fetch godown transactions for all products
      final transactionsFuture = _supabase
          .from('stock_transactions_view')
          .select('''
            product_id,
            transaction_type,
            quantity_strips,
            location_type_source,
            location_type_destination
          ''')
          .inFilter('product_id', productIds);
      
      final results = await Future.wait([mrStockFuture, transactionsFuture]);
      final mrStockData = results[0] as List<dynamic>;
      final transactionsData = results[1] as List<dynamic>;
      
      // Process MR stock data
      final mrStockMap = <String, int>{};
      for (final stockRecord in mrStockData) {
        final productId = stockRecord['product_id'] as String;
        final quantity = stockRecord['current_quantity_strips'] as int? ?? 0;
        mrStockMap[productId] = (mrStockMap[productId] ?? 0) + quantity;
      }
      
      // Process godown stock from transactions
      final godownStockMap = <String, int>{};
      for (final transaction in transactionsData) {
        final productId = transaction['product_id'] as String;
        final txType = transaction['transaction_type'] as String;
        final quantityStrips = transaction['quantity_strips'] as int? ?? 0;
        final locationTypeSource = transaction['location_type_source'] as String?;
        final locationTypeDestination = transaction['location_type_destination'] as String?;
        
        int currentGodownStock = godownStockMap[productId] ?? 0;
        
        // Process transaction based on type for godown stock only
        if (txType == 'STOCK_IN_GODOWN') {
          currentGodownStock += quantityStrips;
        } else if (txType == 'DISPATCH_TO_MR') {
          if (locationTypeSource == 'GODOWN') {
            currentGodownStock += quantityStrips; // DB stores as negative for outflow
          }
        } else if (txType == 'SALE_DIRECT_GODOWN') {
          if (locationTypeSource == 'GODOWN') {
            currentGodownStock += quantityStrips; // DB stores as negative for sales
          }
        } else if (txType.contains('RETURN_TO_GODOWN')) {
          if (locationTypeDestination == 'GODOWN') {
            currentGodownStock += quantityStrips;
          }
        } else if (txType.contains('ADJUST_') || txType.contains('OPENING_STOCK_')) {
          if (txType.contains('_GODOWN') || locationTypeDestination == 'GODOWN') {
            currentGodownStock += quantityStrips;
          }
        }
        
        godownStockMap[productId] = currentGodownStock;
      }
      
      // Combine results
      final result = <String, Map<String, int>>{};
      for (final productId in productIds) {
        result[productId] = {
          'godownStock': (godownStockMap[productId] ?? 0) > 0 ? (godownStockMap[productId] ?? 0) : 0,
          'mrStock': (mrStockMap[productId] ?? 0) > 0 ? (mrStockMap[productId] ?? 0) : 0,
        };
      }
      
      return result;
    } catch (e) {
      return {for (final id in productIds) id: {'godownStock': 0, 'mrStock': 0}};
    }
  }
  
  /// Get stock for a single product (live data)
  static Future<Map<String, int>> getProductStock(String productId) async {
    final stockData = await _getLiveStockDataBatch([productId]);
    return stockData[productId] ?? {'godownStock': 0, 'mrStock': 0};
  }
  
  /// Clear packaging cache if needed (lightweight cache for packaging data only)
  static void invalidatePackagingCache(List<String> productIds) {
    for (final productId in productIds) {
      _packagingCache.remove(productId);
    }
  }
  
  /// Get products without stock data (for faster initial loading)
  static Future<Map<String, dynamic>> getProductsWithoutStock({
    ProductFilters? filters,
    int page = 1,
    int limit = 20,
    String sortField = 'product_name',
    String sortDirection = 'asc',
  }) async {
    return getProducts(
      filters: filters,
      page: page,
      limit: limit,
      sortField: sortField,
      sortDirection: sortDirection,
      includeStock: false,
    );
  }


  
/// Dispose method to clean up resources
  static void dispose() {
    clearPackagingCache();
  }
}
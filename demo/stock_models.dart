class StockItem {
  final String productId;
  final String productName;
  final String productCode;
  final String? genericName;
  final String batchId;
  final String batchNumber;
  final DateTime expiryDate;
  final String locationType;
  final String locationId;
  int currentQuantityStrips;
  double costPerStrip;
  final double totalValue;
  final String? categoryName;
  final int? minStockLevelGodown;
  final int? minStockLevelMr;

  StockItem({
    required this.productId,
    required this.productName,
    required this.productCode,
    this.genericName,
    required this.batchId,
    required this.batchNumber,
    required this.expiryDate,
    required this.locationType,
    required this.locationId,
    required this.currentQuantityStrips,
    required this.costPerStrip,
    required this.totalValue,
    this.categoryName,
    this.minStockLevelGodown,
    this.minStockLevelMr,
  });

  factory StockItem.fromJson(Map<String, dynamic> json) {
    return StockItem(
      productId: json['product_id'] ?? '',
      productName: json['product_name'] ?? '',
      productCode: json['product_code'] ?? '',
      genericName: json['generic_name'],
      batchId: json['batch_id'] ?? '',
      batchNumber: json['batch_number'] ?? '',
      expiryDate: DateTime.parse(json['expiry_date'] ?? DateTime.now().toIso8601String()),
      locationType: json['location_type'] ?? '',
      locationId: json['location_id'] ?? '',
      currentQuantityStrips: json['current_quantity_strips'] ?? 0,
      costPerStrip: (json['cost_per_strip'] ?? 0.0).toDouble(),
      totalValue: (json['total_value'] ?? 0.0).toDouble(),
      categoryName: json['category_name'],
      minStockLevelGodown: json['min_stock_level_godown'],
      minStockLevelMr: json['min_stock_level_mr'],
    );
  }
}

class GroupedStockItem {
  final String productId;
  final String productName;
  final String productCode;
  final String? genericName;
  final String? categoryName;
  final int totalQuantityStrips;
  final double totalValue;
  final int batchCount;
  final List<StockItem> batches;
  final int? minStockLevelGodown;
  final int? minStockLevelMr;

  GroupedStockItem({
    required this.productId,
    required this.productName,
    required this.productCode,
    this.genericName,
    this.categoryName,
    required this.totalQuantityStrips,
    required this.totalValue,
    required this.batchCount,
    required this.batches,
    this.minStockLevelGodown,
    this.minStockLevelMr,
  });
}

class StockSummary {
  final int totalProducts;
  final int totalBatches;
  final double totalValue;
  final int lowStockItems;
  final int expiringSoonItems;

  StockSummary({
    required this.totalProducts,
    required this.totalBatches,
    required this.totalValue,
    required this.lowStockItems,
    required this.expiringSoonItems,
  });
}

class StockFilters {
  final String? productId;
  final String? productName;
  final String? batchNumber;
  final String? categoryId;
  final DateTime? expiryDateFrom;
  final DateTime? expiryDateTo;
  final String? location;
  final String? mrUserId;
  final StockStatus? stockStatus;
  final ExpiryStatus? expiryStatus;

  StockFilters({
    this.productId,
    this.productName,
    this.batchNumber,
    this.categoryId,
    this.expiryDateFrom,
    this.expiryDateTo,
    this.location,
    this.mrUserId,
    this.stockStatus,
    this.expiryStatus,
  });

  StockFilters copyWith({
    String? productId,
    String? productName,
    String? batchNumber,
    String? categoryId,
    DateTime? expiryDateFrom,
    DateTime? expiryDateTo,
    String? location,
    String? mrUserId,
    StockStatus? stockStatus,
    ExpiryStatus? expiryStatus,
  }) {
    return StockFilters(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      batchNumber: batchNumber ?? this.batchNumber,
      categoryId: categoryId ?? this.categoryId,
      expiryDateFrom: expiryDateFrom ?? this.expiryDateFrom,
      expiryDateTo: expiryDateTo ?? this.expiryDateTo,
      location: location ?? this.location,
      mrUserId: mrUserId ?? this.mrUserId,
      stockStatus: stockStatus ?? this.stockStatus,
      expiryStatus: expiryStatus ?? this.expiryStatus,
    );
  }
}

class Product {
  final String id;
  final String productName;
  final String productCode;
  final String? genericName;
  final int? minStockLevelGodown;
  final int? minStockLevelMr;
  final List<ProductCategory>? productCategories;

  Product({
    required this.id,
    required this.productName,
    required this.productCode,
    this.genericName,
    this.minStockLevelGodown,
    this.minStockLevelMr,
    this.productCategories,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      productName: json['product_name'] ?? '',
      productCode: json['product_code'] ?? '',
      genericName: json['generic_name'],
      minStockLevelGodown: json['min_stock_level_godown'],
      minStockLevelMr: json['min_stock_level_mr'],
      productCategories: json['product_categories'] != null
          ? (json['product_categories'] is List
              ? (json['product_categories'] as List)
                  .map((cat) => ProductCategory.fromJson(cat))
                  .toList()
              : [ProductCategory.fromJson(json['product_categories'])])
          : null,
    );
  }
}

class ProductCategory {
  final String categoryName;

  ProductCategory({required this.categoryName});

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      categoryName: json['category_name'] ?? '',
    );
  }
}

class ProductPackagingUnit {
  final String id;
  final String productId;
  final String unitName;
  final int conversionFactorToStrips;
  final bool isBaseUnit;
  final int orderInHierarchy;
  final bool defaultPurchaseUnit;
  final bool defaultSalesUnitMr;
  final bool defaultSalesUnitDirect;
  final String? templateId;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductPackagingUnit({
    required this.id,
    required this.productId,
    required this.unitName,
    required this.conversionFactorToStrips,
    required this.isBaseUnit,
    required this.orderInHierarchy,
    required this.defaultPurchaseUnit,
    required this.defaultSalesUnitMr,
    required this.defaultSalesUnitDirect,
    this.templateId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductPackagingUnit.fromJson(Map<String, dynamic> json) {
    return ProductPackagingUnit(
      id: json['id'] ?? '',
      productId: json['product_id'] ?? '',
      unitName: json['unit_name'] ?? '',
      conversionFactorToStrips: json['conversion_factor_to_strips'] ?? 1,
      isBaseUnit: json['is_base_unit'] ?? false,
      orderInHierarchy: json['order_in_hierarchy'] ?? 1,
      defaultPurchaseUnit: json['default_purchase_unit'] ?? false,
      defaultSalesUnitMr: json['default_sales_unit_mr'] ?? false,
      defaultSalesUnitDirect: json['default_sales_unit_direct'] ?? false,
      templateId: json['template_id'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class Batch {
  final String id;
  final String batchNumber;
  final DateTime expiryDate;

  Batch({
    required this.id,
    required this.batchNumber,
    required this.expiryDate,
  });

  factory Batch.fromJson(Map<String, dynamic> json) {
    return Batch(
      id: json['id'] ?? '',
      batchNumber: json['batch_number'] ?? '',
      expiryDate: DateTime.parse(json['expiry_date'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class Transaction {
  final String productId;
  final String batchId;
  final String transactionType;
  final int quantityStrips;
  final String? locationTypeSource;
  final String? locationIdSource;
  final String? locationTypeDestination;
  final String? locationIdDestination;
  final double costPerStripAtTransaction;
  final String transactionDate;

  Transaction({
    required this.productId,
    required this.batchId,
    required this.transactionType,
    required this.quantityStrips,
    this.locationTypeSource,
    this.locationIdSource,
    this.locationTypeDestination,
    this.locationIdDestination,
    required this.costPerStripAtTransaction,
    required this.transactionDate,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      productId: json['product_id'] ?? '',
      batchId: json['batch_id'] ?? '',
      transactionType: json['transaction_type'] ?? '',
      quantityStrips: json['quantity_strips'] ?? 0,
      locationTypeSource: json['location_type_source'],
      locationIdSource: json['location_id_source'],
      locationTypeDestination: json['location_type_destination'],
      locationIdDestination: json['location_id_destination'],
      costPerStripAtTransaction: (json['cost_per_strip_at_transaction'] ?? 0.0).toDouble(),
      transactionDate: json['transaction_date'] ?? '',
    );
  }
}

enum StockStatus { low, medium, good }
enum ExpiryStatus { expired, expiringSoon, good }
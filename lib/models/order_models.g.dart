// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MrSalesOrder _$MrSalesOrderFromJson(Map<String, dynamic> json) =>
    _MrSalesOrder(
      id: json['id'] as String,
      mrUserId: json['mr_user_id'] as String,
      customerName: json['customer_name'] as String,
      orderDate: DateTime.parse(json['order_date'] as String),
      totalAmount: (json['total_amount'] as num).toDouble(),
      paymentStatus: $enumDecode(
        _$PaymentStatusEnumMap,
        json['payment_status'],
      ),
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => MrSalesOrderItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MrSalesOrderToJson(_MrSalesOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mr_user_id': instance.mrUserId,
      'customer_name': instance.customerName,
      'order_date': instance.orderDate.toIso8601String(),
      'total_amount': instance.totalAmount,
      'payment_status': _$PaymentStatusEnumMap[instance.paymentStatus]!,
      'notes': instance.notes,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'items': instance.items,
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'Pending',
  PaymentStatus.paid: 'Paid',
  PaymentStatus.partial: 'Partial',
};

_MrSalesOrderItem _$MrSalesOrderItemFromJson(Map<String, dynamic> json) =>
    _MrSalesOrderItem(
      id: json['id'] as String,
      orderId: json['order_id'] as String,
      productId: json['product_id'] as String,
      batchId: json['batch_id'] as String,
      quantityStripsSold: (json['quantity_strips_sold'] as num).toInt(),
      pricePerStrip: (json['price_per_strip'] as num).toDouble(),
      lineItemTotal: (json['line_item_total'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
      productName: json['product_name'] as String?,
      batchNumber: json['batch_number'] as String?,
      expiryDate: json['expiry_date'] == null
          ? null
          : DateTime.parse(json['expiry_date'] as String),
      stripsPerBox: (json['strips_per_box'] as num?)?.toInt(),
      boxesPerCarton: (json['boxes_per_carton'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MrSalesOrderItemToJson(_MrSalesOrderItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'product_id': instance.productId,
      'batch_id': instance.batchId,
      'quantity_strips_sold': instance.quantityStripsSold,
      'price_per_strip': instance.pricePerStrip,
      'line_item_total': instance.lineItemTotal,
      'created_at': instance.createdAt.toIso8601String(),
      'product_name': instance.productName,
      'batch_number': instance.batchNumber,
      'expiry_date': instance.expiryDate?.toIso8601String(),
      'strips_per_box': instance.stripsPerBox,
      'boxes_per_carton': instance.boxesPerCarton,
    };

_CartItem _$CartItemFromJson(Map<String, dynamic> json) => _CartItem(
  productId: json['productId'] as String,
  batchId: json['batchId'] as String,
  productName: json['productName'] as String,
  batchNumber: json['batchNumber'] as String,
  expiryDate: DateTime.parse(json['expiryDate'] as String),
  quantityStrips: (json['quantityStrips'] as num).toInt(),
  pricePerStrip: (json['pricePerStrip'] as num).toDouble(),
  stripsPerBox: (json['stripsPerBox'] as num).toInt(),
  boxesPerCarton: (json['boxesPerCarton'] as num).toInt(),
  availableStrips: (json['availableStrips'] as num).toInt(),
);

Map<String, dynamic> _$CartItemToJson(_CartItem instance) => <String, dynamic>{
  'productId': instance.productId,
  'batchId': instance.batchId,
  'productName': instance.productName,
  'batchNumber': instance.batchNumber,
  'expiryDate': instance.expiryDate.toIso8601String(),
  'quantityStrips': instance.quantityStrips,
  'pricePerStrip': instance.pricePerStrip,
  'stripsPerBox': instance.stripsPerBox,
  'boxesPerCarton': instance.boxesPerCarton,
  'availableStrips': instance.availableStrips,
};

_MrStockItem _$MrStockItemFromJson(Map<String, dynamic> json) => _MrStockItem(
  productId: json['productId'] as String,
  batchId: json['batchId'] as String,
  productName: json['productName'] as String,
  batchNumber: json['batchNumber'] as String,
  expiryDate: DateTime.parse(json['expiryDate'] as String),
  currentQuantityStrips: (json['currentQuantityStrips'] as num).toInt(),
  pricePerStrip: (json['pricePerStrip'] as num).toDouble(),
  stripsPerBox: (json['stripsPerBox'] as num).toInt(),
  boxesPerCarton: (json['boxesPerCarton'] as num).toInt(),
  manufacturer: json['manufacturer'] as String?,
  genericName: json['genericName'] as String?,
);

Map<String, dynamic> _$MrStockItemToJson(_MrStockItem instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'batchId': instance.batchId,
      'productName': instance.productName,
      'batchNumber': instance.batchNumber,
      'expiryDate': instance.expiryDate.toIso8601String(),
      'currentQuantityStrips': instance.currentQuantityStrips,
      'pricePerStrip': instance.pricePerStrip,
      'stripsPerBox': instance.stripsPerBox,
      'boxesPerCarton': instance.boxesPerCarton,
      'manufacturer': instance.manufacturer,
      'genericName': instance.genericName,
    };

_OrderFormData _$OrderFormDataFromJson(Map<String, dynamic> json) =>
    _OrderFormData(
      customerName: json['customerName'] as String? ?? '',
      notes: json['notes'] as String? ?? '',
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$OrderFormDataToJson(_OrderFormData instance) =>
    <String, dynamic>{
      'customerName': instance.customerName,
      'notes': instance.notes,
      'items': instance.items,
    };

_QuantityInput _$QuantityInputFromJson(Map<String, dynamic> json) =>
    _QuantityInput(
      cartons: (json['cartons'] as num?)?.toInt() ?? 0,
      boxes: (json['boxes'] as num?)?.toInt() ?? 0,
      strips: (json['strips'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$QuantityInputToJson(_QuantityInput instance) =>
    <String, dynamic>{
      'cartons': instance.cartons,
      'boxes': instance.boxes,
      'strips': instance.strips,
    };

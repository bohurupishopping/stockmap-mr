// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MrSalesOrder _$MrSalesOrderFromJson(Map<String, dynamic> json) =>
    _MrSalesOrder(
      id: json['id'] as String,
      mrUserId: json['mrUserId'] as String,
      customerName: json['customerName'] as String,
      orderDate: DateTime.parse(json['orderDate'] as String),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      paymentStatus: $enumDecode(_$PaymentStatusEnumMap, json['paymentStatus']),
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => MrSalesOrderItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MrSalesOrderToJson(_MrSalesOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mrUserId': instance.mrUserId,
      'customerName': instance.customerName,
      'orderDate': instance.orderDate.toIso8601String(),
      'totalAmount': instance.totalAmount,
      'paymentStatus': _$PaymentStatusEnumMap[instance.paymentStatus]!,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
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
      orderId: json['orderId'] as String,
      productId: json['productId'] as String,
      batchId: json['batchId'] as String,
      quantityStripsSold: (json['quantityStripsSold'] as num).toInt(),
      pricePerStrip: (json['pricePerStrip'] as num).toDouble(),
      lineItemTotal: (json['lineItemTotal'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      productName: json['productName'] as String?,
      batchNumber: json['batchNumber'] as String?,
      expiryDate: json['expiryDate'] == null
          ? null
          : DateTime.parse(json['expiryDate'] as String),
      stripsPerBox: (json['stripsPerBox'] as num?)?.toInt(),
      boxesPerCarton: (json['boxesPerCarton'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MrSalesOrderItemToJson(_MrSalesOrderItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'productId': instance.productId,
      'batchId': instance.batchId,
      'quantityStripsSold': instance.quantityStripsSold,
      'pricePerStrip': instance.pricePerStrip,
      'lineItemTotal': instance.lineItemTotal,
      'createdAt': instance.createdAt.toIso8601String(),
      'productName': instance.productName,
      'batchNumber': instance.batchNumber,
      'expiryDate': instance.expiryDate?.toIso8601String(),
      'stripsPerBox': instance.stripsPerBox,
      'boxesPerCarton': instance.boxesPerCarton,
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

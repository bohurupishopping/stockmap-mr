import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_models.freezed.dart';
part 'order_models.g.dart';

@freezed
abstract class MrSalesOrder with _$MrSalesOrder {
  const MrSalesOrder._();
  
  const factory MrSalesOrder({
    required String id,
    required String mrUserId,
    required String customerName,
    required DateTime orderDate,
    required double totalAmount,
    required PaymentStatus paymentStatus,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<MrSalesOrderItem> items,
  }) = _MrSalesOrder;

  factory MrSalesOrder.fromJson(Map<String, dynamic> json) =>
      _$MrSalesOrderFromJson(json);
}

@freezed
abstract class MrSalesOrderItem with _$MrSalesOrderItem {
  const MrSalesOrderItem._();

  const factory MrSalesOrderItem({
    required String id,
    required String orderId,
    required String productId,
    required String batchId,
    required int quantityStripsSold,
    required double pricePerStrip,
    required double lineItemTotal,
    required DateTime createdAt,
    String? productName,
    String? batchNumber,
    DateTime? expiryDate,
    int? stripsPerBox,
    int? boxesPerCarton,
  }) = _MrSalesOrderItem;

  factory MrSalesOrderItem.fromJson(Map<String, dynamic> json) =>
      _$MrSalesOrderItemFromJson(json);
}

@freezed
abstract class CartItem with _$CartItem {
  const CartItem._();

  const factory CartItem({
    required String productId,
    required String batchId,
    required String productName,
    required String batchNumber,
    required DateTime expiryDate,
    required int quantityStrips,
    required double pricePerStrip,
    required int stripsPerBox,
    required int boxesPerCarton,
    required int availableStrips,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}

@freezed
abstract class MrStockItem with _$MrStockItem {
  const MrStockItem._();

  const factory MrStockItem({
    required String productId,
    required String batchId,
    required String productName,
    required String batchNumber,
    required DateTime expiryDate,
    required int currentQuantityStrips,
    required double pricePerStrip,
    required int stripsPerBox,
    required int boxesPerCarton,
    String? manufacturer,
    String? genericName,
  }) = _MrStockItem;

  factory MrStockItem.fromJson(Map<String, dynamic> json) =>
      _$MrStockItemFromJson(json);
}

enum PaymentStatus {
  @JsonValue('Pending')
  pending,
  @JsonValue('Paid')
  paid,
  @JsonValue('Partial')
  partial,
}

@freezed
abstract class OrderFormData with _$OrderFormData {
  const OrderFormData._();

  const factory OrderFormData({
    @Default('') String customerName,
    @Default('') String notes,
    @Default([]) List<CartItem> items,
  }) = _OrderFormData;

  factory OrderFormData.fromJson(Map<String, dynamic> json) =>
      _$OrderFormDataFromJson(json);
}

@freezed
abstract class QuantityInput with _$QuantityInput {
  const QuantityInput._();

  const factory QuantityInput({
    @Default(0) int cartons,
    @Default(0) int boxes,
    @Default(0) int strips,
  }) = _QuantityInput;

  factory QuantityInput.fromJson(Map<String, dynamic> json) =>
      _$QuantityInputFromJson(json);
}

extension QuantityInputExtension on QuantityInput {
  int toTotalStrips(int stripsPerBox, int boxesPerCarton) {
    final stripsFromCartons = cartons * boxesPerCarton * stripsPerBox;
    final stripsFromBoxes = boxes * stripsPerBox;
    return stripsFromCartons + stripsFromBoxes + strips;
  }
}

class QuantityInputHelper {
  static QuantityInput fromTotalStrips(
    int totalStrips,
    int stripsPerBox,
    int boxesPerCarton,
  ) {
    final stripsPerCarton = boxesPerCarton * stripsPerBox;
    final cartons = totalStrips ~/ stripsPerCarton;
    final remainingAfterCartons = totalStrips % stripsPerCarton;
    final boxes = remainingAfterCartons ~/ stripsPerBox;
    final strips = remainingAfterCartons % stripsPerBox;
    
    return QuantityInput(
      cartons: cartons,
      boxes: boxes,
      strips: strips,
    );
  }
}
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/order_models.dart';

part 'new_order_event.freezed.dart';

@freezed
class NewOrderEvent with _$NewOrderEvent {
  const factory NewOrderEvent.loadMrStock() = LoadMrStock;
  
  const factory NewOrderEvent.addItemToCart({
    required MrStockItem stockItem,
    required int quantityStrips,
  }) = AddItemToCart;
  
  const factory NewOrderEvent.removeItemFromCart({
    required String productId,
    required String batchId,
  }) = RemoveItemFromCart;
  
  const factory NewOrderEvent.updateCartItemQuantity({
    required String productId,
    required String batchId,
    required int newQuantityStrips,
  }) = UpdateCartItemQuantity;
  
  const factory NewOrderEvent.clearCart() = ClearCart;
  
  const factory NewOrderEvent.updateCustomerName({
    required String customerName,
  }) = UpdateCustomerName;
  
  const factory NewOrderEvent.updateNotes({
    required String notes,
  }) = UpdateNotes;
  
  const factory NewOrderEvent.validateAndCreateOrder() = ValidateAndCreateOrder;
  
  const factory NewOrderEvent.resetOrderState() = ResetOrderState;
}
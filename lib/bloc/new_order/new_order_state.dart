import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/order_models.dart';

part 'new_order_state.freezed.dart';


@freezed
abstract class NewOrderState with _$NewOrderState {
  const factory NewOrderState({
    @Default(false) bool isLoadingStock,
    @Default(false) bool isCreatingOrder,
    @Default([]) List<MrStockItem> availableStock,
    @Default([]) List<CartItem> cartItems,
    @Default('') String customerName,
    @Default('') String notes,
    String? errorMessage,
    String? successMessage,
    @Default(false) bool isOrderCreated,
    String? createdOrderId,
    @Default([]) List<Map<String, dynamic>> stockValidationErrors,
  }) = _NewOrderState;

  const NewOrderState._();

  double get totalAmount {
    return cartItems.fold<double>(
      0.0,
      (sum, item) => sum + (item.quantityStrips * item.pricePerStrip),
    );
  }

  int get totalItemsInCart {
    return cartItems.fold<int>(
      0,
      (sum, item) => sum + item.quantityStrips,
    );
  }

  bool get canCreateOrder {
    return customerName.trim().isNotEmpty &&
        cartItems.isNotEmpty &&
        !isCreatingOrder &&
        !isLoadingStock;
  }

  bool get hasError => errorMessage != null;
  bool get hasSuccess => successMessage != null;
  bool get hasStockValidationErrors => stockValidationErrors.isNotEmpty;
}
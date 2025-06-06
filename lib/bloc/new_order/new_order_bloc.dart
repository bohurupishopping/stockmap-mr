import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/order_models.dart';
import '../../services/order_service.dart';
import 'new_order_event.dart';
import 'new_order_state.dart';

class NewOrderBloc extends Bloc<NewOrderEvent, NewOrderState> {
  NewOrderBloc() : super(const NewOrderState()) {
    on<LoadMrStock>(_onLoadMrStock);
    on<AddItemToCart>(_onAddItemToCart);
    on<RemoveItemFromCart>(_onRemoveItemFromCart);
    on<UpdateCartItemQuantity>(_onUpdateCartItemQuantity);
    on<ClearCart>(_onClearCart);
    on<UpdateCustomerName>(_onUpdateCustomerName);
    on<UpdateNotes>(_onUpdateNotes);
    on<ValidateAndCreateOrder>(_onValidateAndCreateOrder);
    on<ResetOrderState>(_onResetOrderState);
  }

  Future<void> _onLoadMrStock(
    LoadMrStock event,
    Emitter<NewOrderState> emit,
  ) async {
    emit(state.copyWith(
      isLoadingStock: true,
      errorMessage: null,
    ));

    try {
      final stock = await OrderService.getMrStock();
      emit(state.copyWith(
        isLoadingStock: false,
        availableStock: stock,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoadingStock: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onAddItemToCart(
    AddItemToCart event,
    Emitter<NewOrderState> emit,
  ) async {
    try {
      // Check if item already exists in cart
      final existingItemIndex = state.cartItems.indexWhere(
        (item) =>
            item.productId == event.stockItem.productId &&
            item.batchId == event.stockItem.batchId,
      );

      List<CartItem> updatedCart;

      if (existingItemIndex != -1) {
        // Update existing item quantity
        final existingItem = state.cartItems[existingItemIndex];
        final newQuantity = existingItem.quantityStrips + event.quantityStrips;
        
        // Check if new quantity exceeds available stock
        if (newQuantity > event.stockItem.currentQuantityStrips) {
          emit(state.copyWith(
            errorMessage:
                'Cannot add ${event.quantityStrips} strips. Only ${event.stockItem.currentQuantityStrips - existingItem.quantityStrips} strips available.',
          ));
          return;
        }

        updatedCart = List.from(state.cartItems);
        updatedCart[existingItemIndex] = existingItem.copyWith(
          quantityStrips: newQuantity,
        );
      } else {
        // Add new item to cart
        if (event.quantityStrips > event.stockItem.currentQuantityStrips) {
          emit(state.copyWith(
            errorMessage:
                'Cannot add ${event.quantityStrips} strips. Only ${event.stockItem.currentQuantityStrips} strips available.',
          ));
          return;
        }

        final cartItem = CartItem(
          productId: event.stockItem.productId,
          batchId: event.stockItem.batchId,
          productName: event.stockItem.productName,
          batchNumber: event.stockItem.batchNumber,
          expiryDate: event.stockItem.expiryDate,
          quantityStrips: event.quantityStrips,
          pricePerStrip: event.stockItem.pricePerStrip,
          stripsPerBox: event.stockItem.stripsPerBox,
          boxesPerCarton: event.stockItem.boxesPerCarton,
          availableStrips: event.stockItem.currentQuantityStrips,
        );

        updatedCart = [...state.cartItems, cartItem];
      }

      emit(state.copyWith(
        cartItems: updatedCart,
        errorMessage: null,
        successMessage: 'Item added to cart successfully',
      ));

      // Clear success message after a delay
      await Future.delayed(const Duration(seconds: 2));
      if (!emit.isDone) {
        emit(state.copyWith(successMessage: null));
      }
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to add item to cart: $e',
      ));
    }
  }

  Future<void> _onRemoveItemFromCart(
    RemoveItemFromCart event,
    Emitter<NewOrderState> emit,
  ) async {
    final updatedCart = state.cartItems
        .where((item) =>
            !(item.productId == event.productId &&
              item.batchId == event.batchId))
        .toList();

    emit(state.copyWith(
      cartItems: updatedCart,
      errorMessage: null,
    ));
  }

  Future<void> _onUpdateCartItemQuantity(
    UpdateCartItemQuantity event,
    Emitter<NewOrderState> emit,
  ) async {
    try {
      final itemIndex = state.cartItems.indexWhere(
        (item) =>
            item.productId == event.productId &&
            item.batchId == event.batchId,
      );

      if (itemIndex == -1) {
        emit(state.copyWith(
          errorMessage: 'Item not found in cart',
        ));
        return;
      }

      final item = state.cartItems[itemIndex];
      
      // Validate new quantity
      if (event.newQuantityStrips <= 0) {
        // Remove item if quantity is 0 or negative
        add(RemoveItemFromCart(
          productId: event.productId,
          batchId: event.batchId,
        ));
        return;
      }

      if (event.newQuantityStrips > item.availableStrips) {
        emit(state.copyWith(
          errorMessage:
              'Cannot set quantity to ${event.newQuantityStrips}. Only ${item.availableStrips} strips available.',
        ));
        return;
      }

      final updatedCart = List<CartItem>.from(state.cartItems);
      updatedCart[itemIndex] = item.copyWith(
        quantityStrips: event.newQuantityStrips,
      );

      emit(state.copyWith(
        cartItems: updatedCart,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to update item quantity: $e',
      ));
    }
  }

  Future<void> _onClearCart(
    ClearCart event,
    Emitter<NewOrderState> emit,
  ) async {
    emit(state.copyWith(
      cartItems: [],
      errorMessage: null,
    ));
  }

  Future<void> _onUpdateCustomerName(
    UpdateCustomerName event,
    Emitter<NewOrderState> emit,
  ) async {
    emit(state.copyWith(
      customerName: event.customerName,
      errorMessage: null,
    ));
  }

  Future<void> _onUpdateNotes(
    UpdateNotes event,
    Emitter<NewOrderState> emit,
  ) async {
    emit(state.copyWith(
      notes: event.notes,
      errorMessage: null,
    ));
  }

  Future<void> _onValidateAndCreateOrder(
    ValidateAndCreateOrder event,
    Emitter<NewOrderState> emit,
  ) async {
    if (!state.canCreateOrder) {
      emit(state.copyWith(
        errorMessage: 'Please fill in customer name and add items to cart',
      ));
      return;
    }

    emit(state.copyWith(
      isCreatingOrder: true,
      errorMessage: null,
      stockValidationErrors: [],
    ));

    try {
      // First validate stock availability
      final validation = await OrderService.validateStockAvailability(
        state.cartItems,
      );

      if (!validation['is_valid']) {
        emit(state.copyWith(
          isCreatingOrder: false,
          stockValidationErrors:
              List<Map<String, dynamic>>.from(validation['unavailable_items']),
          errorMessage: 'Some items have insufficient stock. Please review and adjust quantities.',
        ));
        return;
      }

      // Create the order
      final orderId = await OrderService.createSalesOrder(
        customerName: state.customerName,
        items: state.cartItems,
        notes: state.notes.isEmpty ? null : state.notes,
      );

      emit(state.copyWith(
        isCreatingOrder: false,
        isOrderCreated: true,
        createdOrderId: orderId,
        successMessage: 'Order created successfully!',
        cartItems: [], // Clear cart after successful order
        customerName: '', // Reset form
        notes: '', // Reset form
      ));
    } catch (e) {
      emit(state.copyWith(
        isCreatingOrder: false,
        errorMessage: 'Failed to create order: $e',
      ));
    }
  }

  Future<void> _onResetOrderState(
    ResetOrderState event,
    Emitter<NewOrderState> emit,
  ) async {
    emit(const NewOrderState());
  }
}
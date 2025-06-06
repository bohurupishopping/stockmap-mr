// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_order_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NewOrderState {

 bool get isLoadingStock; bool get isCreatingOrder; List<MrStockItem> get availableStock; List<CartItem> get cartItems; String get customerName; String get notes; String? get errorMessage; String? get successMessage; bool get isOrderCreated; String? get createdOrderId; List<Map<String, dynamic>> get stockValidationErrors;
/// Create a copy of NewOrderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewOrderStateCopyWith<NewOrderState> get copyWith => _$NewOrderStateCopyWithImpl<NewOrderState>(this as NewOrderState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewOrderState&&(identical(other.isLoadingStock, isLoadingStock) || other.isLoadingStock == isLoadingStock)&&(identical(other.isCreatingOrder, isCreatingOrder) || other.isCreatingOrder == isCreatingOrder)&&const DeepCollectionEquality().equals(other.availableStock, availableStock)&&const DeepCollectionEquality().equals(other.cartItems, cartItems)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage)&&(identical(other.isOrderCreated, isOrderCreated) || other.isOrderCreated == isOrderCreated)&&(identical(other.createdOrderId, createdOrderId) || other.createdOrderId == createdOrderId)&&const DeepCollectionEquality().equals(other.stockValidationErrors, stockValidationErrors));
}


@override
int get hashCode => Object.hash(runtimeType,isLoadingStock,isCreatingOrder,const DeepCollectionEquality().hash(availableStock),const DeepCollectionEquality().hash(cartItems),customerName,notes,errorMessage,successMessage,isOrderCreated,createdOrderId,const DeepCollectionEquality().hash(stockValidationErrors));

@override
String toString() {
  return 'NewOrderState(isLoadingStock: $isLoadingStock, isCreatingOrder: $isCreatingOrder, availableStock: $availableStock, cartItems: $cartItems, customerName: $customerName, notes: $notes, errorMessage: $errorMessage, successMessage: $successMessage, isOrderCreated: $isOrderCreated, createdOrderId: $createdOrderId, stockValidationErrors: $stockValidationErrors)';
}


}

/// @nodoc
abstract mixin class $NewOrderStateCopyWith<$Res>  {
  factory $NewOrderStateCopyWith(NewOrderState value, $Res Function(NewOrderState) _then) = _$NewOrderStateCopyWithImpl;
@useResult
$Res call({
 bool isLoadingStock, bool isCreatingOrder, List<MrStockItem> availableStock, List<CartItem> cartItems, String customerName, String notes, String? errorMessage, String? successMessage, bool isOrderCreated, String? createdOrderId, List<Map<String, dynamic>> stockValidationErrors
});




}
/// @nodoc
class _$NewOrderStateCopyWithImpl<$Res>
    implements $NewOrderStateCopyWith<$Res> {
  _$NewOrderStateCopyWithImpl(this._self, this._then);

  final NewOrderState _self;
  final $Res Function(NewOrderState) _then;

/// Create a copy of NewOrderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoadingStock = null,Object? isCreatingOrder = null,Object? availableStock = null,Object? cartItems = null,Object? customerName = null,Object? notes = null,Object? errorMessage = freezed,Object? successMessage = freezed,Object? isOrderCreated = null,Object? createdOrderId = freezed,Object? stockValidationErrors = null,}) {
  return _then(_self.copyWith(
isLoadingStock: null == isLoadingStock ? _self.isLoadingStock : isLoadingStock // ignore: cast_nullable_to_non_nullable
as bool,isCreatingOrder: null == isCreatingOrder ? _self.isCreatingOrder : isCreatingOrder // ignore: cast_nullable_to_non_nullable
as bool,availableStock: null == availableStock ? _self.availableStock : availableStock // ignore: cast_nullable_to_non_nullable
as List<MrStockItem>,cartItems: null == cartItems ? _self.cartItems : cartItems // ignore: cast_nullable_to_non_nullable
as List<CartItem>,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,isOrderCreated: null == isOrderCreated ? _self.isOrderCreated : isOrderCreated // ignore: cast_nullable_to_non_nullable
as bool,createdOrderId: freezed == createdOrderId ? _self.createdOrderId : createdOrderId // ignore: cast_nullable_to_non_nullable
as String?,stockValidationErrors: null == stockValidationErrors ? _self.stockValidationErrors : stockValidationErrors // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,
  ));
}

}


/// @nodoc


class _NewOrderState extends NewOrderState {
  const _NewOrderState({this.isLoadingStock = false, this.isCreatingOrder = false, final  List<MrStockItem> availableStock = const [], final  List<CartItem> cartItems = const [], this.customerName = '', this.notes = '', this.errorMessage, this.successMessage, this.isOrderCreated = false, this.createdOrderId, final  List<Map<String, dynamic>> stockValidationErrors = const []}): _availableStock = availableStock,_cartItems = cartItems,_stockValidationErrors = stockValidationErrors,super._();
  

@override@JsonKey() final  bool isLoadingStock;
@override@JsonKey() final  bool isCreatingOrder;
 final  List<MrStockItem> _availableStock;
@override@JsonKey() List<MrStockItem> get availableStock {
  if (_availableStock is EqualUnmodifiableListView) return _availableStock;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableStock);
}

 final  List<CartItem> _cartItems;
@override@JsonKey() List<CartItem> get cartItems {
  if (_cartItems is EqualUnmodifiableListView) return _cartItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cartItems);
}

@override@JsonKey() final  String customerName;
@override@JsonKey() final  String notes;
@override final  String? errorMessage;
@override final  String? successMessage;
@override@JsonKey() final  bool isOrderCreated;
@override final  String? createdOrderId;
 final  List<Map<String, dynamic>> _stockValidationErrors;
@override@JsonKey() List<Map<String, dynamic>> get stockValidationErrors {
  if (_stockValidationErrors is EqualUnmodifiableListView) return _stockValidationErrors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stockValidationErrors);
}


/// Create a copy of NewOrderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewOrderStateCopyWith<_NewOrderState> get copyWith => __$NewOrderStateCopyWithImpl<_NewOrderState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewOrderState&&(identical(other.isLoadingStock, isLoadingStock) || other.isLoadingStock == isLoadingStock)&&(identical(other.isCreatingOrder, isCreatingOrder) || other.isCreatingOrder == isCreatingOrder)&&const DeepCollectionEquality().equals(other._availableStock, _availableStock)&&const DeepCollectionEquality().equals(other._cartItems, _cartItems)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage)&&(identical(other.isOrderCreated, isOrderCreated) || other.isOrderCreated == isOrderCreated)&&(identical(other.createdOrderId, createdOrderId) || other.createdOrderId == createdOrderId)&&const DeepCollectionEquality().equals(other._stockValidationErrors, _stockValidationErrors));
}


@override
int get hashCode => Object.hash(runtimeType,isLoadingStock,isCreatingOrder,const DeepCollectionEquality().hash(_availableStock),const DeepCollectionEquality().hash(_cartItems),customerName,notes,errorMessage,successMessage,isOrderCreated,createdOrderId,const DeepCollectionEquality().hash(_stockValidationErrors));

@override
String toString() {
  return 'NewOrderState(isLoadingStock: $isLoadingStock, isCreatingOrder: $isCreatingOrder, availableStock: $availableStock, cartItems: $cartItems, customerName: $customerName, notes: $notes, errorMessage: $errorMessage, successMessage: $successMessage, isOrderCreated: $isOrderCreated, createdOrderId: $createdOrderId, stockValidationErrors: $stockValidationErrors)';
}


}

/// @nodoc
abstract mixin class _$NewOrderStateCopyWith<$Res> implements $NewOrderStateCopyWith<$Res> {
  factory _$NewOrderStateCopyWith(_NewOrderState value, $Res Function(_NewOrderState) _then) = __$NewOrderStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoadingStock, bool isCreatingOrder, List<MrStockItem> availableStock, List<CartItem> cartItems, String customerName, String notes, String? errorMessage, String? successMessage, bool isOrderCreated, String? createdOrderId, List<Map<String, dynamic>> stockValidationErrors
});




}
/// @nodoc
class __$NewOrderStateCopyWithImpl<$Res>
    implements _$NewOrderStateCopyWith<$Res> {
  __$NewOrderStateCopyWithImpl(this._self, this._then);

  final _NewOrderState _self;
  final $Res Function(_NewOrderState) _then;

/// Create a copy of NewOrderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoadingStock = null,Object? isCreatingOrder = null,Object? availableStock = null,Object? cartItems = null,Object? customerName = null,Object? notes = null,Object? errorMessage = freezed,Object? successMessage = freezed,Object? isOrderCreated = null,Object? createdOrderId = freezed,Object? stockValidationErrors = null,}) {
  return _then(_NewOrderState(
isLoadingStock: null == isLoadingStock ? _self.isLoadingStock : isLoadingStock // ignore: cast_nullable_to_non_nullable
as bool,isCreatingOrder: null == isCreatingOrder ? _self.isCreatingOrder : isCreatingOrder // ignore: cast_nullable_to_non_nullable
as bool,availableStock: null == availableStock ? _self._availableStock : availableStock // ignore: cast_nullable_to_non_nullable
as List<MrStockItem>,cartItems: null == cartItems ? _self._cartItems : cartItems // ignore: cast_nullable_to_non_nullable
as List<CartItem>,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,isOrderCreated: null == isOrderCreated ? _self.isOrderCreated : isOrderCreated // ignore: cast_nullable_to_non_nullable
as bool,createdOrderId: freezed == createdOrderId ? _self.createdOrderId : createdOrderId // ignore: cast_nullable_to_non_nullable
as String?,stockValidationErrors: null == stockValidationErrors ? _self._stockValidationErrors : stockValidationErrors // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,
  ));
}


}

// dart format on

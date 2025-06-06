// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_order_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NewOrderEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewOrderEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NewOrderEvent()';
}


}

/// @nodoc
class $NewOrderEventCopyWith<$Res>  {
$NewOrderEventCopyWith(NewOrderEvent _, $Res Function(NewOrderEvent) __);
}


/// @nodoc


class LoadMrStock implements NewOrderEvent {
  const LoadMrStock();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadMrStock);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NewOrderEvent.loadMrStock()';
}


}




/// @nodoc


class AddItemToCart implements NewOrderEvent {
  const AddItemToCart({required this.stockItem, required this.quantityStrips});
  

 final  MrStockItem stockItem;
 final  int quantityStrips;

/// Create a copy of NewOrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddItemToCartCopyWith<AddItemToCart> get copyWith => _$AddItemToCartCopyWithImpl<AddItemToCart>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddItemToCart&&(identical(other.stockItem, stockItem) || other.stockItem == stockItem)&&(identical(other.quantityStrips, quantityStrips) || other.quantityStrips == quantityStrips));
}


@override
int get hashCode => Object.hash(runtimeType,stockItem,quantityStrips);

@override
String toString() {
  return 'NewOrderEvent.addItemToCart(stockItem: $stockItem, quantityStrips: $quantityStrips)';
}


}

/// @nodoc
abstract mixin class $AddItemToCartCopyWith<$Res> implements $NewOrderEventCopyWith<$Res> {
  factory $AddItemToCartCopyWith(AddItemToCart value, $Res Function(AddItemToCart) _then) = _$AddItemToCartCopyWithImpl;
@useResult
$Res call({
 MrStockItem stockItem, int quantityStrips
});


$MrStockItemCopyWith<$Res> get stockItem;

}
/// @nodoc
class _$AddItemToCartCopyWithImpl<$Res>
    implements $AddItemToCartCopyWith<$Res> {
  _$AddItemToCartCopyWithImpl(this._self, this._then);

  final AddItemToCart _self;
  final $Res Function(AddItemToCart) _then;

/// Create a copy of NewOrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stockItem = null,Object? quantityStrips = null,}) {
  return _then(AddItemToCart(
stockItem: null == stockItem ? _self.stockItem : stockItem // ignore: cast_nullable_to_non_nullable
as MrStockItem,quantityStrips: null == quantityStrips ? _self.quantityStrips : quantityStrips // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of NewOrderEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MrStockItemCopyWith<$Res> get stockItem {
  
  return $MrStockItemCopyWith<$Res>(_self.stockItem, (value) {
    return _then(_self.copyWith(stockItem: value));
  });
}
}

/// @nodoc


class RemoveItemFromCart implements NewOrderEvent {
  const RemoveItemFromCart({required this.productId, required this.batchId});
  

 final  String productId;
 final  String batchId;

/// Create a copy of NewOrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoveItemFromCartCopyWith<RemoveItemFromCart> get copyWith => _$RemoveItemFromCartCopyWithImpl<RemoveItemFromCart>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoveItemFromCart&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.batchId, batchId) || other.batchId == batchId));
}


@override
int get hashCode => Object.hash(runtimeType,productId,batchId);

@override
String toString() {
  return 'NewOrderEvent.removeItemFromCart(productId: $productId, batchId: $batchId)';
}


}

/// @nodoc
abstract mixin class $RemoveItemFromCartCopyWith<$Res> implements $NewOrderEventCopyWith<$Res> {
  factory $RemoveItemFromCartCopyWith(RemoveItemFromCart value, $Res Function(RemoveItemFromCart) _then) = _$RemoveItemFromCartCopyWithImpl;
@useResult
$Res call({
 String productId, String batchId
});




}
/// @nodoc
class _$RemoveItemFromCartCopyWithImpl<$Res>
    implements $RemoveItemFromCartCopyWith<$Res> {
  _$RemoveItemFromCartCopyWithImpl(this._self, this._then);

  final RemoveItemFromCart _self;
  final $Res Function(RemoveItemFromCart) _then;

/// Create a copy of NewOrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? batchId = null,}) {
  return _then(RemoveItemFromCart(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,batchId: null == batchId ? _self.batchId : batchId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UpdateCartItemQuantity implements NewOrderEvent {
  const UpdateCartItemQuantity({required this.productId, required this.batchId, required this.newQuantityStrips});
  

 final  String productId;
 final  String batchId;
 final  int newQuantityStrips;

/// Create a copy of NewOrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateCartItemQuantityCopyWith<UpdateCartItemQuantity> get copyWith => _$UpdateCartItemQuantityCopyWithImpl<UpdateCartItemQuantity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateCartItemQuantity&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.batchId, batchId) || other.batchId == batchId)&&(identical(other.newQuantityStrips, newQuantityStrips) || other.newQuantityStrips == newQuantityStrips));
}


@override
int get hashCode => Object.hash(runtimeType,productId,batchId,newQuantityStrips);

@override
String toString() {
  return 'NewOrderEvent.updateCartItemQuantity(productId: $productId, batchId: $batchId, newQuantityStrips: $newQuantityStrips)';
}


}

/// @nodoc
abstract mixin class $UpdateCartItemQuantityCopyWith<$Res> implements $NewOrderEventCopyWith<$Res> {
  factory $UpdateCartItemQuantityCopyWith(UpdateCartItemQuantity value, $Res Function(UpdateCartItemQuantity) _then) = _$UpdateCartItemQuantityCopyWithImpl;
@useResult
$Res call({
 String productId, String batchId, int newQuantityStrips
});




}
/// @nodoc
class _$UpdateCartItemQuantityCopyWithImpl<$Res>
    implements $UpdateCartItemQuantityCopyWith<$Res> {
  _$UpdateCartItemQuantityCopyWithImpl(this._self, this._then);

  final UpdateCartItemQuantity _self;
  final $Res Function(UpdateCartItemQuantity) _then;

/// Create a copy of NewOrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? batchId = null,Object? newQuantityStrips = null,}) {
  return _then(UpdateCartItemQuantity(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,batchId: null == batchId ? _self.batchId : batchId // ignore: cast_nullable_to_non_nullable
as String,newQuantityStrips: null == newQuantityStrips ? _self.newQuantityStrips : newQuantityStrips // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ClearCart implements NewOrderEvent {
  const ClearCart();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClearCart);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NewOrderEvent.clearCart()';
}


}




/// @nodoc


class UpdateCustomerName implements NewOrderEvent {
  const UpdateCustomerName({required this.customerName});
  

 final  String customerName;

/// Create a copy of NewOrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateCustomerNameCopyWith<UpdateCustomerName> get copyWith => _$UpdateCustomerNameCopyWithImpl<UpdateCustomerName>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateCustomerName&&(identical(other.customerName, customerName) || other.customerName == customerName));
}


@override
int get hashCode => Object.hash(runtimeType,customerName);

@override
String toString() {
  return 'NewOrderEvent.updateCustomerName(customerName: $customerName)';
}


}

/// @nodoc
abstract mixin class $UpdateCustomerNameCopyWith<$Res> implements $NewOrderEventCopyWith<$Res> {
  factory $UpdateCustomerNameCopyWith(UpdateCustomerName value, $Res Function(UpdateCustomerName) _then) = _$UpdateCustomerNameCopyWithImpl;
@useResult
$Res call({
 String customerName
});




}
/// @nodoc
class _$UpdateCustomerNameCopyWithImpl<$Res>
    implements $UpdateCustomerNameCopyWith<$Res> {
  _$UpdateCustomerNameCopyWithImpl(this._self, this._then);

  final UpdateCustomerName _self;
  final $Res Function(UpdateCustomerName) _then;

/// Create a copy of NewOrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? customerName = null,}) {
  return _then(UpdateCustomerName(
customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UpdateNotes implements NewOrderEvent {
  const UpdateNotes({required this.notes});
  

 final  String notes;

/// Create a copy of NewOrderEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateNotesCopyWith<UpdateNotes> get copyWith => _$UpdateNotesCopyWithImpl<UpdateNotes>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateNotes&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,notes);

@override
String toString() {
  return 'NewOrderEvent.updateNotes(notes: $notes)';
}


}

/// @nodoc
abstract mixin class $UpdateNotesCopyWith<$Res> implements $NewOrderEventCopyWith<$Res> {
  factory $UpdateNotesCopyWith(UpdateNotes value, $Res Function(UpdateNotes) _then) = _$UpdateNotesCopyWithImpl;
@useResult
$Res call({
 String notes
});




}
/// @nodoc
class _$UpdateNotesCopyWithImpl<$Res>
    implements $UpdateNotesCopyWith<$Res> {
  _$UpdateNotesCopyWithImpl(this._self, this._then);

  final UpdateNotes _self;
  final $Res Function(UpdateNotes) _then;

/// Create a copy of NewOrderEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? notes = null,}) {
  return _then(UpdateNotes(
notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ValidateAndCreateOrder implements NewOrderEvent {
  const ValidateAndCreateOrder();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValidateAndCreateOrder);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NewOrderEvent.validateAndCreateOrder()';
}


}




/// @nodoc


class ResetOrderState implements NewOrderEvent {
  const ResetOrderState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetOrderState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NewOrderEvent.resetOrderState()';
}


}




// dart format on

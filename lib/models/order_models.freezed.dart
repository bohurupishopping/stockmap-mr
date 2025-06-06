// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MrSalesOrder {

 String get id; String get mrUserId; String get customerName; DateTime get orderDate; double get totalAmount; PaymentStatus get paymentStatus; String? get notes; DateTime get createdAt; DateTime get updatedAt; List<MrSalesOrderItem> get items;
/// Create a copy of MrSalesOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MrSalesOrderCopyWith<MrSalesOrder> get copyWith => _$MrSalesOrderCopyWithImpl<MrSalesOrder>(this as MrSalesOrder, _$identity);

  /// Serializes this MrSalesOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MrSalesOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.mrUserId, mrUserId) || other.mrUserId == mrUserId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.orderDate, orderDate) || other.orderDate == orderDate)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mrUserId,customerName,orderDate,totalAmount,paymentStatus,notes,createdAt,updatedAt,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'MrSalesOrder(id: $id, mrUserId: $mrUserId, customerName: $customerName, orderDate: $orderDate, totalAmount: $totalAmount, paymentStatus: $paymentStatus, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, items: $items)';
}


}

/// @nodoc
abstract mixin class $MrSalesOrderCopyWith<$Res>  {
  factory $MrSalesOrderCopyWith(MrSalesOrder value, $Res Function(MrSalesOrder) _then) = _$MrSalesOrderCopyWithImpl;
@useResult
$Res call({
 String id, String mrUserId, String customerName, DateTime orderDate, double totalAmount, PaymentStatus paymentStatus, String? notes, DateTime createdAt, DateTime updatedAt, List<MrSalesOrderItem> items
});




}
/// @nodoc
class _$MrSalesOrderCopyWithImpl<$Res>
    implements $MrSalesOrderCopyWith<$Res> {
  _$MrSalesOrderCopyWithImpl(this._self, this._then);

  final MrSalesOrder _self;
  final $Res Function(MrSalesOrder) _then;

/// Create a copy of MrSalesOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? mrUserId = null,Object? customerName = null,Object? orderDate = null,Object? totalAmount = null,Object? paymentStatus = null,Object? notes = freezed,Object? createdAt = null,Object? updatedAt = null,Object? items = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mrUserId: null == mrUserId ? _self.mrUserId : mrUserId // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,orderDate: null == orderDate ? _self.orderDate : orderDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatus,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<MrSalesOrderItem>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MrSalesOrder extends MrSalesOrder {
  const _MrSalesOrder({required this.id, required this.mrUserId, required this.customerName, required this.orderDate, required this.totalAmount, required this.paymentStatus, this.notes, required this.createdAt, required this.updatedAt, final  List<MrSalesOrderItem> items = const []}): _items = items,super._();
  factory _MrSalesOrder.fromJson(Map<String, dynamic> json) => _$MrSalesOrderFromJson(json);

@override final  String id;
@override final  String mrUserId;
@override final  String customerName;
@override final  DateTime orderDate;
@override final  double totalAmount;
@override final  PaymentStatus paymentStatus;
@override final  String? notes;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
 final  List<MrSalesOrderItem> _items;
@override@JsonKey() List<MrSalesOrderItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of MrSalesOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MrSalesOrderCopyWith<_MrSalesOrder> get copyWith => __$MrSalesOrderCopyWithImpl<_MrSalesOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MrSalesOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MrSalesOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.mrUserId, mrUserId) || other.mrUserId == mrUserId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.orderDate, orderDate) || other.orderDate == orderDate)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mrUserId,customerName,orderDate,totalAmount,paymentStatus,notes,createdAt,updatedAt,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'MrSalesOrder(id: $id, mrUserId: $mrUserId, customerName: $customerName, orderDate: $orderDate, totalAmount: $totalAmount, paymentStatus: $paymentStatus, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, items: $items)';
}


}

/// @nodoc
abstract mixin class _$MrSalesOrderCopyWith<$Res> implements $MrSalesOrderCopyWith<$Res> {
  factory _$MrSalesOrderCopyWith(_MrSalesOrder value, $Res Function(_MrSalesOrder) _then) = __$MrSalesOrderCopyWithImpl;
@override @useResult
$Res call({
 String id, String mrUserId, String customerName, DateTime orderDate, double totalAmount, PaymentStatus paymentStatus, String? notes, DateTime createdAt, DateTime updatedAt, List<MrSalesOrderItem> items
});




}
/// @nodoc
class __$MrSalesOrderCopyWithImpl<$Res>
    implements _$MrSalesOrderCopyWith<$Res> {
  __$MrSalesOrderCopyWithImpl(this._self, this._then);

  final _MrSalesOrder _self;
  final $Res Function(_MrSalesOrder) _then;

/// Create a copy of MrSalesOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mrUserId = null,Object? customerName = null,Object? orderDate = null,Object? totalAmount = null,Object? paymentStatus = null,Object? notes = freezed,Object? createdAt = null,Object? updatedAt = null,Object? items = null,}) {
  return _then(_MrSalesOrder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mrUserId: null == mrUserId ? _self.mrUserId : mrUserId // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,orderDate: null == orderDate ? _self.orderDate : orderDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatus,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<MrSalesOrderItem>,
  ));
}


}


/// @nodoc
mixin _$MrSalesOrderItem {

 String get id; String get orderId; String get productId; String get batchId; int get quantityStripsSold; double get pricePerStrip; double get lineItemTotal; DateTime get createdAt; String? get productName; String? get batchNumber; DateTime? get expiryDate; int? get stripsPerBox; int? get boxesPerCarton;
/// Create a copy of MrSalesOrderItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MrSalesOrderItemCopyWith<MrSalesOrderItem> get copyWith => _$MrSalesOrderItemCopyWithImpl<MrSalesOrderItem>(this as MrSalesOrderItem, _$identity);

  /// Serializes this MrSalesOrderItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MrSalesOrderItem&&(identical(other.id, id) || other.id == id)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.batchId, batchId) || other.batchId == batchId)&&(identical(other.quantityStripsSold, quantityStripsSold) || other.quantityStripsSold == quantityStripsSold)&&(identical(other.pricePerStrip, pricePerStrip) || other.pricePerStrip == pricePerStrip)&&(identical(other.lineItemTotal, lineItemTotal) || other.lineItemTotal == lineItemTotal)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.batchNumber, batchNumber) || other.batchNumber == batchNumber)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.stripsPerBox, stripsPerBox) || other.stripsPerBox == stripsPerBox)&&(identical(other.boxesPerCarton, boxesPerCarton) || other.boxesPerCarton == boxesPerCarton));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderId,productId,batchId,quantityStripsSold,pricePerStrip,lineItemTotal,createdAt,productName,batchNumber,expiryDate,stripsPerBox,boxesPerCarton);

@override
String toString() {
  return 'MrSalesOrderItem(id: $id, orderId: $orderId, productId: $productId, batchId: $batchId, quantityStripsSold: $quantityStripsSold, pricePerStrip: $pricePerStrip, lineItemTotal: $lineItemTotal, createdAt: $createdAt, productName: $productName, batchNumber: $batchNumber, expiryDate: $expiryDate, stripsPerBox: $stripsPerBox, boxesPerCarton: $boxesPerCarton)';
}


}

/// @nodoc
abstract mixin class $MrSalesOrderItemCopyWith<$Res>  {
  factory $MrSalesOrderItemCopyWith(MrSalesOrderItem value, $Res Function(MrSalesOrderItem) _then) = _$MrSalesOrderItemCopyWithImpl;
@useResult
$Res call({
 String id, String orderId, String productId, String batchId, int quantityStripsSold, double pricePerStrip, double lineItemTotal, DateTime createdAt, String? productName, String? batchNumber, DateTime? expiryDate, int? stripsPerBox, int? boxesPerCarton
});




}
/// @nodoc
class _$MrSalesOrderItemCopyWithImpl<$Res>
    implements $MrSalesOrderItemCopyWith<$Res> {
  _$MrSalesOrderItemCopyWithImpl(this._self, this._then);

  final MrSalesOrderItem _self;
  final $Res Function(MrSalesOrderItem) _then;

/// Create a copy of MrSalesOrderItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderId = null,Object? productId = null,Object? batchId = null,Object? quantityStripsSold = null,Object? pricePerStrip = null,Object? lineItemTotal = null,Object? createdAt = null,Object? productName = freezed,Object? batchNumber = freezed,Object? expiryDate = freezed,Object? stripsPerBox = freezed,Object? boxesPerCarton = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,batchId: null == batchId ? _self.batchId : batchId // ignore: cast_nullable_to_non_nullable
as String,quantityStripsSold: null == quantityStripsSold ? _self.quantityStripsSold : quantityStripsSold // ignore: cast_nullable_to_non_nullable
as int,pricePerStrip: null == pricePerStrip ? _self.pricePerStrip : pricePerStrip // ignore: cast_nullable_to_non_nullable
as double,lineItemTotal: null == lineItemTotal ? _self.lineItemTotal : lineItemTotal // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,batchNumber: freezed == batchNumber ? _self.batchNumber : batchNumber // ignore: cast_nullable_to_non_nullable
as String?,expiryDate: freezed == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,stripsPerBox: freezed == stripsPerBox ? _self.stripsPerBox : stripsPerBox // ignore: cast_nullable_to_non_nullable
as int?,boxesPerCarton: freezed == boxesPerCarton ? _self.boxesPerCarton : boxesPerCarton // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MrSalesOrderItem extends MrSalesOrderItem {
  const _MrSalesOrderItem({required this.id, required this.orderId, required this.productId, required this.batchId, required this.quantityStripsSold, required this.pricePerStrip, required this.lineItemTotal, required this.createdAt, this.productName, this.batchNumber, this.expiryDate, this.stripsPerBox, this.boxesPerCarton}): super._();
  factory _MrSalesOrderItem.fromJson(Map<String, dynamic> json) => _$MrSalesOrderItemFromJson(json);

@override final  String id;
@override final  String orderId;
@override final  String productId;
@override final  String batchId;
@override final  int quantityStripsSold;
@override final  double pricePerStrip;
@override final  double lineItemTotal;
@override final  DateTime createdAt;
@override final  String? productName;
@override final  String? batchNumber;
@override final  DateTime? expiryDate;
@override final  int? stripsPerBox;
@override final  int? boxesPerCarton;

/// Create a copy of MrSalesOrderItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MrSalesOrderItemCopyWith<_MrSalesOrderItem> get copyWith => __$MrSalesOrderItemCopyWithImpl<_MrSalesOrderItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MrSalesOrderItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MrSalesOrderItem&&(identical(other.id, id) || other.id == id)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.batchId, batchId) || other.batchId == batchId)&&(identical(other.quantityStripsSold, quantityStripsSold) || other.quantityStripsSold == quantityStripsSold)&&(identical(other.pricePerStrip, pricePerStrip) || other.pricePerStrip == pricePerStrip)&&(identical(other.lineItemTotal, lineItemTotal) || other.lineItemTotal == lineItemTotal)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.batchNumber, batchNumber) || other.batchNumber == batchNumber)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.stripsPerBox, stripsPerBox) || other.stripsPerBox == stripsPerBox)&&(identical(other.boxesPerCarton, boxesPerCarton) || other.boxesPerCarton == boxesPerCarton));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderId,productId,batchId,quantityStripsSold,pricePerStrip,lineItemTotal,createdAt,productName,batchNumber,expiryDate,stripsPerBox,boxesPerCarton);

@override
String toString() {
  return 'MrSalesOrderItem(id: $id, orderId: $orderId, productId: $productId, batchId: $batchId, quantityStripsSold: $quantityStripsSold, pricePerStrip: $pricePerStrip, lineItemTotal: $lineItemTotal, createdAt: $createdAt, productName: $productName, batchNumber: $batchNumber, expiryDate: $expiryDate, stripsPerBox: $stripsPerBox, boxesPerCarton: $boxesPerCarton)';
}


}

/// @nodoc
abstract mixin class _$MrSalesOrderItemCopyWith<$Res> implements $MrSalesOrderItemCopyWith<$Res> {
  factory _$MrSalesOrderItemCopyWith(_MrSalesOrderItem value, $Res Function(_MrSalesOrderItem) _then) = __$MrSalesOrderItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String orderId, String productId, String batchId, int quantityStripsSold, double pricePerStrip, double lineItemTotal, DateTime createdAt, String? productName, String? batchNumber, DateTime? expiryDate, int? stripsPerBox, int? boxesPerCarton
});




}
/// @nodoc
class __$MrSalesOrderItemCopyWithImpl<$Res>
    implements _$MrSalesOrderItemCopyWith<$Res> {
  __$MrSalesOrderItemCopyWithImpl(this._self, this._then);

  final _MrSalesOrderItem _self;
  final $Res Function(_MrSalesOrderItem) _then;

/// Create a copy of MrSalesOrderItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderId = null,Object? productId = null,Object? batchId = null,Object? quantityStripsSold = null,Object? pricePerStrip = null,Object? lineItemTotal = null,Object? createdAt = null,Object? productName = freezed,Object? batchNumber = freezed,Object? expiryDate = freezed,Object? stripsPerBox = freezed,Object? boxesPerCarton = freezed,}) {
  return _then(_MrSalesOrderItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,batchId: null == batchId ? _self.batchId : batchId // ignore: cast_nullable_to_non_nullable
as String,quantityStripsSold: null == quantityStripsSold ? _self.quantityStripsSold : quantityStripsSold // ignore: cast_nullable_to_non_nullable
as int,pricePerStrip: null == pricePerStrip ? _self.pricePerStrip : pricePerStrip // ignore: cast_nullable_to_non_nullable
as double,lineItemTotal: null == lineItemTotal ? _self.lineItemTotal : lineItemTotal // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,batchNumber: freezed == batchNumber ? _self.batchNumber : batchNumber // ignore: cast_nullable_to_non_nullable
as String?,expiryDate: freezed == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,stripsPerBox: freezed == stripsPerBox ? _self.stripsPerBox : stripsPerBox // ignore: cast_nullable_to_non_nullable
as int?,boxesPerCarton: freezed == boxesPerCarton ? _self.boxesPerCarton : boxesPerCarton // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$CartItem {

 String get productId; String get batchId; String get productName; String get batchNumber; DateTime get expiryDate; int get quantityStrips; double get pricePerStrip; int get stripsPerBox; int get boxesPerCarton; int get availableStrips;
/// Create a copy of CartItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartItemCopyWith<CartItem> get copyWith => _$CartItemCopyWithImpl<CartItem>(this as CartItem, _$identity);

  /// Serializes this CartItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartItem&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.batchId, batchId) || other.batchId == batchId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.batchNumber, batchNumber) || other.batchNumber == batchNumber)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.quantityStrips, quantityStrips) || other.quantityStrips == quantityStrips)&&(identical(other.pricePerStrip, pricePerStrip) || other.pricePerStrip == pricePerStrip)&&(identical(other.stripsPerBox, stripsPerBox) || other.stripsPerBox == stripsPerBox)&&(identical(other.boxesPerCarton, boxesPerCarton) || other.boxesPerCarton == boxesPerCarton)&&(identical(other.availableStrips, availableStrips) || other.availableStrips == availableStrips));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productId,batchId,productName,batchNumber,expiryDate,quantityStrips,pricePerStrip,stripsPerBox,boxesPerCarton,availableStrips);

@override
String toString() {
  return 'CartItem(productId: $productId, batchId: $batchId, productName: $productName, batchNumber: $batchNumber, expiryDate: $expiryDate, quantityStrips: $quantityStrips, pricePerStrip: $pricePerStrip, stripsPerBox: $stripsPerBox, boxesPerCarton: $boxesPerCarton, availableStrips: $availableStrips)';
}


}

/// @nodoc
abstract mixin class $CartItemCopyWith<$Res>  {
  factory $CartItemCopyWith(CartItem value, $Res Function(CartItem) _then) = _$CartItemCopyWithImpl;
@useResult
$Res call({
 String productId, String batchId, String productName, String batchNumber, DateTime expiryDate, int quantityStrips, double pricePerStrip, int stripsPerBox, int boxesPerCarton, int availableStrips
});




}
/// @nodoc
class _$CartItemCopyWithImpl<$Res>
    implements $CartItemCopyWith<$Res> {
  _$CartItemCopyWithImpl(this._self, this._then);

  final CartItem _self;
  final $Res Function(CartItem) _then;

/// Create a copy of CartItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = null,Object? batchId = null,Object? productName = null,Object? batchNumber = null,Object? expiryDate = null,Object? quantityStrips = null,Object? pricePerStrip = null,Object? stripsPerBox = null,Object? boxesPerCarton = null,Object? availableStrips = null,}) {
  return _then(_self.copyWith(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,batchId: null == batchId ? _self.batchId : batchId // ignore: cast_nullable_to_non_nullable
as String,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,batchNumber: null == batchNumber ? _self.batchNumber : batchNumber // ignore: cast_nullable_to_non_nullable
as String,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,quantityStrips: null == quantityStrips ? _self.quantityStrips : quantityStrips // ignore: cast_nullable_to_non_nullable
as int,pricePerStrip: null == pricePerStrip ? _self.pricePerStrip : pricePerStrip // ignore: cast_nullable_to_non_nullable
as double,stripsPerBox: null == stripsPerBox ? _self.stripsPerBox : stripsPerBox // ignore: cast_nullable_to_non_nullable
as int,boxesPerCarton: null == boxesPerCarton ? _self.boxesPerCarton : boxesPerCarton // ignore: cast_nullable_to_non_nullable
as int,availableStrips: null == availableStrips ? _self.availableStrips : availableStrips // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CartItem extends CartItem {
  const _CartItem({required this.productId, required this.batchId, required this.productName, required this.batchNumber, required this.expiryDate, required this.quantityStrips, required this.pricePerStrip, required this.stripsPerBox, required this.boxesPerCarton, required this.availableStrips}): super._();
  factory _CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);

@override final  String productId;
@override final  String batchId;
@override final  String productName;
@override final  String batchNumber;
@override final  DateTime expiryDate;
@override final  int quantityStrips;
@override final  double pricePerStrip;
@override final  int stripsPerBox;
@override final  int boxesPerCarton;
@override final  int availableStrips;

/// Create a copy of CartItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartItemCopyWith<_CartItem> get copyWith => __$CartItemCopyWithImpl<_CartItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CartItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartItem&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.batchId, batchId) || other.batchId == batchId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.batchNumber, batchNumber) || other.batchNumber == batchNumber)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.quantityStrips, quantityStrips) || other.quantityStrips == quantityStrips)&&(identical(other.pricePerStrip, pricePerStrip) || other.pricePerStrip == pricePerStrip)&&(identical(other.stripsPerBox, stripsPerBox) || other.stripsPerBox == stripsPerBox)&&(identical(other.boxesPerCarton, boxesPerCarton) || other.boxesPerCarton == boxesPerCarton)&&(identical(other.availableStrips, availableStrips) || other.availableStrips == availableStrips));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productId,batchId,productName,batchNumber,expiryDate,quantityStrips,pricePerStrip,stripsPerBox,boxesPerCarton,availableStrips);

@override
String toString() {
  return 'CartItem(productId: $productId, batchId: $batchId, productName: $productName, batchNumber: $batchNumber, expiryDate: $expiryDate, quantityStrips: $quantityStrips, pricePerStrip: $pricePerStrip, stripsPerBox: $stripsPerBox, boxesPerCarton: $boxesPerCarton, availableStrips: $availableStrips)';
}


}

/// @nodoc
abstract mixin class _$CartItemCopyWith<$Res> implements $CartItemCopyWith<$Res> {
  factory _$CartItemCopyWith(_CartItem value, $Res Function(_CartItem) _then) = __$CartItemCopyWithImpl;
@override @useResult
$Res call({
 String productId, String batchId, String productName, String batchNumber, DateTime expiryDate, int quantityStrips, double pricePerStrip, int stripsPerBox, int boxesPerCarton, int availableStrips
});




}
/// @nodoc
class __$CartItemCopyWithImpl<$Res>
    implements _$CartItemCopyWith<$Res> {
  __$CartItemCopyWithImpl(this._self, this._then);

  final _CartItem _self;
  final $Res Function(_CartItem) _then;

/// Create a copy of CartItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? batchId = null,Object? productName = null,Object? batchNumber = null,Object? expiryDate = null,Object? quantityStrips = null,Object? pricePerStrip = null,Object? stripsPerBox = null,Object? boxesPerCarton = null,Object? availableStrips = null,}) {
  return _then(_CartItem(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,batchId: null == batchId ? _self.batchId : batchId // ignore: cast_nullable_to_non_nullable
as String,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,batchNumber: null == batchNumber ? _self.batchNumber : batchNumber // ignore: cast_nullable_to_non_nullable
as String,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,quantityStrips: null == quantityStrips ? _self.quantityStrips : quantityStrips // ignore: cast_nullable_to_non_nullable
as int,pricePerStrip: null == pricePerStrip ? _self.pricePerStrip : pricePerStrip // ignore: cast_nullable_to_non_nullable
as double,stripsPerBox: null == stripsPerBox ? _self.stripsPerBox : stripsPerBox // ignore: cast_nullable_to_non_nullable
as int,boxesPerCarton: null == boxesPerCarton ? _self.boxesPerCarton : boxesPerCarton // ignore: cast_nullable_to_non_nullable
as int,availableStrips: null == availableStrips ? _self.availableStrips : availableStrips // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MrStockItem {

 String get productId; String get batchId; String get productName; String get batchNumber; DateTime get expiryDate; int get currentQuantityStrips; double get pricePerStrip; int get stripsPerBox; int get boxesPerCarton; String? get manufacturer; String? get genericName;
/// Create a copy of MrStockItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MrStockItemCopyWith<MrStockItem> get copyWith => _$MrStockItemCopyWithImpl<MrStockItem>(this as MrStockItem, _$identity);

  /// Serializes this MrStockItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MrStockItem&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.batchId, batchId) || other.batchId == batchId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.batchNumber, batchNumber) || other.batchNumber == batchNumber)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.currentQuantityStrips, currentQuantityStrips) || other.currentQuantityStrips == currentQuantityStrips)&&(identical(other.pricePerStrip, pricePerStrip) || other.pricePerStrip == pricePerStrip)&&(identical(other.stripsPerBox, stripsPerBox) || other.stripsPerBox == stripsPerBox)&&(identical(other.boxesPerCarton, boxesPerCarton) || other.boxesPerCarton == boxesPerCarton)&&(identical(other.manufacturer, manufacturer) || other.manufacturer == manufacturer)&&(identical(other.genericName, genericName) || other.genericName == genericName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productId,batchId,productName,batchNumber,expiryDate,currentQuantityStrips,pricePerStrip,stripsPerBox,boxesPerCarton,manufacturer,genericName);

@override
String toString() {
  return 'MrStockItem(productId: $productId, batchId: $batchId, productName: $productName, batchNumber: $batchNumber, expiryDate: $expiryDate, currentQuantityStrips: $currentQuantityStrips, pricePerStrip: $pricePerStrip, stripsPerBox: $stripsPerBox, boxesPerCarton: $boxesPerCarton, manufacturer: $manufacturer, genericName: $genericName)';
}


}

/// @nodoc
abstract mixin class $MrStockItemCopyWith<$Res>  {
  factory $MrStockItemCopyWith(MrStockItem value, $Res Function(MrStockItem) _then) = _$MrStockItemCopyWithImpl;
@useResult
$Res call({
 String productId, String batchId, String productName, String batchNumber, DateTime expiryDate, int currentQuantityStrips, double pricePerStrip, int stripsPerBox, int boxesPerCarton, String? manufacturer, String? genericName
});




}
/// @nodoc
class _$MrStockItemCopyWithImpl<$Res>
    implements $MrStockItemCopyWith<$Res> {
  _$MrStockItemCopyWithImpl(this._self, this._then);

  final MrStockItem _self;
  final $Res Function(MrStockItem) _then;

/// Create a copy of MrStockItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = null,Object? batchId = null,Object? productName = null,Object? batchNumber = null,Object? expiryDate = null,Object? currentQuantityStrips = null,Object? pricePerStrip = null,Object? stripsPerBox = null,Object? boxesPerCarton = null,Object? manufacturer = freezed,Object? genericName = freezed,}) {
  return _then(_self.copyWith(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,batchId: null == batchId ? _self.batchId : batchId // ignore: cast_nullable_to_non_nullable
as String,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,batchNumber: null == batchNumber ? _self.batchNumber : batchNumber // ignore: cast_nullable_to_non_nullable
as String,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,currentQuantityStrips: null == currentQuantityStrips ? _self.currentQuantityStrips : currentQuantityStrips // ignore: cast_nullable_to_non_nullable
as int,pricePerStrip: null == pricePerStrip ? _self.pricePerStrip : pricePerStrip // ignore: cast_nullable_to_non_nullable
as double,stripsPerBox: null == stripsPerBox ? _self.stripsPerBox : stripsPerBox // ignore: cast_nullable_to_non_nullable
as int,boxesPerCarton: null == boxesPerCarton ? _self.boxesPerCarton : boxesPerCarton // ignore: cast_nullable_to_non_nullable
as int,manufacturer: freezed == manufacturer ? _self.manufacturer : manufacturer // ignore: cast_nullable_to_non_nullable
as String?,genericName: freezed == genericName ? _self.genericName : genericName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MrStockItem extends MrStockItem {
  const _MrStockItem({required this.productId, required this.batchId, required this.productName, required this.batchNumber, required this.expiryDate, required this.currentQuantityStrips, required this.pricePerStrip, required this.stripsPerBox, required this.boxesPerCarton, this.manufacturer, this.genericName}): super._();
  factory _MrStockItem.fromJson(Map<String, dynamic> json) => _$MrStockItemFromJson(json);

@override final  String productId;
@override final  String batchId;
@override final  String productName;
@override final  String batchNumber;
@override final  DateTime expiryDate;
@override final  int currentQuantityStrips;
@override final  double pricePerStrip;
@override final  int stripsPerBox;
@override final  int boxesPerCarton;
@override final  String? manufacturer;
@override final  String? genericName;

/// Create a copy of MrStockItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MrStockItemCopyWith<_MrStockItem> get copyWith => __$MrStockItemCopyWithImpl<_MrStockItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MrStockItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MrStockItem&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.batchId, batchId) || other.batchId == batchId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.batchNumber, batchNumber) || other.batchNumber == batchNumber)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.currentQuantityStrips, currentQuantityStrips) || other.currentQuantityStrips == currentQuantityStrips)&&(identical(other.pricePerStrip, pricePerStrip) || other.pricePerStrip == pricePerStrip)&&(identical(other.stripsPerBox, stripsPerBox) || other.stripsPerBox == stripsPerBox)&&(identical(other.boxesPerCarton, boxesPerCarton) || other.boxesPerCarton == boxesPerCarton)&&(identical(other.manufacturer, manufacturer) || other.manufacturer == manufacturer)&&(identical(other.genericName, genericName) || other.genericName == genericName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productId,batchId,productName,batchNumber,expiryDate,currentQuantityStrips,pricePerStrip,stripsPerBox,boxesPerCarton,manufacturer,genericName);

@override
String toString() {
  return 'MrStockItem(productId: $productId, batchId: $batchId, productName: $productName, batchNumber: $batchNumber, expiryDate: $expiryDate, currentQuantityStrips: $currentQuantityStrips, pricePerStrip: $pricePerStrip, stripsPerBox: $stripsPerBox, boxesPerCarton: $boxesPerCarton, manufacturer: $manufacturer, genericName: $genericName)';
}


}

/// @nodoc
abstract mixin class _$MrStockItemCopyWith<$Res> implements $MrStockItemCopyWith<$Res> {
  factory _$MrStockItemCopyWith(_MrStockItem value, $Res Function(_MrStockItem) _then) = __$MrStockItemCopyWithImpl;
@override @useResult
$Res call({
 String productId, String batchId, String productName, String batchNumber, DateTime expiryDate, int currentQuantityStrips, double pricePerStrip, int stripsPerBox, int boxesPerCarton, String? manufacturer, String? genericName
});




}
/// @nodoc
class __$MrStockItemCopyWithImpl<$Res>
    implements _$MrStockItemCopyWith<$Res> {
  __$MrStockItemCopyWithImpl(this._self, this._then);

  final _MrStockItem _self;
  final $Res Function(_MrStockItem) _then;

/// Create a copy of MrStockItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? batchId = null,Object? productName = null,Object? batchNumber = null,Object? expiryDate = null,Object? currentQuantityStrips = null,Object? pricePerStrip = null,Object? stripsPerBox = null,Object? boxesPerCarton = null,Object? manufacturer = freezed,Object? genericName = freezed,}) {
  return _then(_MrStockItem(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,batchId: null == batchId ? _self.batchId : batchId // ignore: cast_nullable_to_non_nullable
as String,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,batchNumber: null == batchNumber ? _self.batchNumber : batchNumber // ignore: cast_nullable_to_non_nullable
as String,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,currentQuantityStrips: null == currentQuantityStrips ? _self.currentQuantityStrips : currentQuantityStrips // ignore: cast_nullable_to_non_nullable
as int,pricePerStrip: null == pricePerStrip ? _self.pricePerStrip : pricePerStrip // ignore: cast_nullable_to_non_nullable
as double,stripsPerBox: null == stripsPerBox ? _self.stripsPerBox : stripsPerBox // ignore: cast_nullable_to_non_nullable
as int,boxesPerCarton: null == boxesPerCarton ? _self.boxesPerCarton : boxesPerCarton // ignore: cast_nullable_to_non_nullable
as int,manufacturer: freezed == manufacturer ? _self.manufacturer : manufacturer // ignore: cast_nullable_to_non_nullable
as String?,genericName: freezed == genericName ? _self.genericName : genericName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$OrderFormData {

 String get customerName; String get notes; List<CartItem> get items;
/// Create a copy of OrderFormData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderFormDataCopyWith<OrderFormData> get copyWith => _$OrderFormDataCopyWithImpl<OrderFormData>(this as OrderFormData, _$identity);

  /// Serializes this OrderFormData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderFormData&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,customerName,notes,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'OrderFormData(customerName: $customerName, notes: $notes, items: $items)';
}


}

/// @nodoc
abstract mixin class $OrderFormDataCopyWith<$Res>  {
  factory $OrderFormDataCopyWith(OrderFormData value, $Res Function(OrderFormData) _then) = _$OrderFormDataCopyWithImpl;
@useResult
$Res call({
 String customerName, String notes, List<CartItem> items
});




}
/// @nodoc
class _$OrderFormDataCopyWithImpl<$Res>
    implements $OrderFormDataCopyWith<$Res> {
  _$OrderFormDataCopyWithImpl(this._self, this._then);

  final OrderFormData _self;
  final $Res Function(OrderFormData) _then;

/// Create a copy of OrderFormData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? customerName = null,Object? notes = null,Object? items = null,}) {
  return _then(_self.copyWith(
customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CartItem>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _OrderFormData extends OrderFormData {
  const _OrderFormData({this.customerName = '', this.notes = '', final  List<CartItem> items = const []}): _items = items,super._();
  factory _OrderFormData.fromJson(Map<String, dynamic> json) => _$OrderFormDataFromJson(json);

@override@JsonKey() final  String customerName;
@override@JsonKey() final  String notes;
 final  List<CartItem> _items;
@override@JsonKey() List<CartItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of OrderFormData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderFormDataCopyWith<_OrderFormData> get copyWith => __$OrderFormDataCopyWithImpl<_OrderFormData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderFormDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderFormData&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,customerName,notes,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'OrderFormData(customerName: $customerName, notes: $notes, items: $items)';
}


}

/// @nodoc
abstract mixin class _$OrderFormDataCopyWith<$Res> implements $OrderFormDataCopyWith<$Res> {
  factory _$OrderFormDataCopyWith(_OrderFormData value, $Res Function(_OrderFormData) _then) = __$OrderFormDataCopyWithImpl;
@override @useResult
$Res call({
 String customerName, String notes, List<CartItem> items
});




}
/// @nodoc
class __$OrderFormDataCopyWithImpl<$Res>
    implements _$OrderFormDataCopyWith<$Res> {
  __$OrderFormDataCopyWithImpl(this._self, this._then);

  final _OrderFormData _self;
  final $Res Function(_OrderFormData) _then;

/// Create a copy of OrderFormData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? customerName = null,Object? notes = null,Object? items = null,}) {
  return _then(_OrderFormData(
customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CartItem>,
  ));
}


}


/// @nodoc
mixin _$QuantityInput {

 int get cartons; int get boxes; int get strips;
/// Create a copy of QuantityInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuantityInputCopyWith<QuantityInput> get copyWith => _$QuantityInputCopyWithImpl<QuantityInput>(this as QuantityInput, _$identity);

  /// Serializes this QuantityInput to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuantityInput&&(identical(other.cartons, cartons) || other.cartons == cartons)&&(identical(other.boxes, boxes) || other.boxes == boxes)&&(identical(other.strips, strips) || other.strips == strips));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cartons,boxes,strips);

@override
String toString() {
  return 'QuantityInput(cartons: $cartons, boxes: $boxes, strips: $strips)';
}


}

/// @nodoc
abstract mixin class $QuantityInputCopyWith<$Res>  {
  factory $QuantityInputCopyWith(QuantityInput value, $Res Function(QuantityInput) _then) = _$QuantityInputCopyWithImpl;
@useResult
$Res call({
 int cartons, int boxes, int strips
});




}
/// @nodoc
class _$QuantityInputCopyWithImpl<$Res>
    implements $QuantityInputCopyWith<$Res> {
  _$QuantityInputCopyWithImpl(this._self, this._then);

  final QuantityInput _self;
  final $Res Function(QuantityInput) _then;

/// Create a copy of QuantityInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cartons = null,Object? boxes = null,Object? strips = null,}) {
  return _then(_self.copyWith(
cartons: null == cartons ? _self.cartons : cartons // ignore: cast_nullable_to_non_nullable
as int,boxes: null == boxes ? _self.boxes : boxes // ignore: cast_nullable_to_non_nullable
as int,strips: null == strips ? _self.strips : strips // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _QuantityInput extends QuantityInput {
  const _QuantityInput({this.cartons = 0, this.boxes = 0, this.strips = 0}): super._();
  factory _QuantityInput.fromJson(Map<String, dynamic> json) => _$QuantityInputFromJson(json);

@override@JsonKey() final  int cartons;
@override@JsonKey() final  int boxes;
@override@JsonKey() final  int strips;

/// Create a copy of QuantityInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuantityInputCopyWith<_QuantityInput> get copyWith => __$QuantityInputCopyWithImpl<_QuantityInput>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuantityInputToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuantityInput&&(identical(other.cartons, cartons) || other.cartons == cartons)&&(identical(other.boxes, boxes) || other.boxes == boxes)&&(identical(other.strips, strips) || other.strips == strips));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cartons,boxes,strips);

@override
String toString() {
  return 'QuantityInput(cartons: $cartons, boxes: $boxes, strips: $strips)';
}


}

/// @nodoc
abstract mixin class _$QuantityInputCopyWith<$Res> implements $QuantityInputCopyWith<$Res> {
  factory _$QuantityInputCopyWith(_QuantityInput value, $Res Function(_QuantityInput) _then) = __$QuantityInputCopyWithImpl;
@override @useResult
$Res call({
 int cartons, int boxes, int strips
});




}
/// @nodoc
class __$QuantityInputCopyWithImpl<$Res>
    implements _$QuantityInputCopyWith<$Res> {
  __$QuantityInputCopyWithImpl(this._self, this._then);

  final _QuantityInput _self;
  final $Res Function(_QuantityInput) _then;

/// Create a copy of QuantityInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cartons = null,Object? boxes = null,Object? strips = null,}) {
  return _then(_QuantityInput(
cartons: null == cartons ? _self.cartons : cartons // ignore: cast_nullable_to_non_nullable
as int,boxes: null == boxes ? _self.boxes : boxes // ignore: cast_nullable_to_non_nullable
as int,strips: null == strips ? _self.strips : strips // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

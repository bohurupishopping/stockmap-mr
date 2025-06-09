// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'target_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MrSalesTarget {

 String get id;@JsonKey(name: 'mr_user_id') String get mrUserId;@JsonKey(name: 'period_type') TargetPeriodType get periodType;@JsonKey(name: 'start_date') DateTime get startDate;@JsonKey(name: 'end_date') DateTime get endDate;@JsonKey(name: 'target_sales_amount') double get targetSalesAmount;@JsonKey(name: 'target_tier_bronze') double? get targetTierBronze;@JsonKey(name: 'target_tier_gold') double? get targetTierGold;@JsonKey(name: 'product_specific_goals') Map<String, dynamic>? get productSpecificGoals;@JsonKey(name: 'target_collection_percentage') double? get targetCollectionPercentage;@JsonKey(name: 'is_locked') bool get isLocked;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of MrSalesTarget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MrSalesTargetCopyWith<MrSalesTarget> get copyWith => _$MrSalesTargetCopyWithImpl<MrSalesTarget>(this as MrSalesTarget, _$identity);

  /// Serializes this MrSalesTarget to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MrSalesTarget&&(identical(other.id, id) || other.id == id)&&(identical(other.mrUserId, mrUserId) || other.mrUserId == mrUserId)&&(identical(other.periodType, periodType) || other.periodType == periodType)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.targetSalesAmount, targetSalesAmount) || other.targetSalesAmount == targetSalesAmount)&&(identical(other.targetTierBronze, targetTierBronze) || other.targetTierBronze == targetTierBronze)&&(identical(other.targetTierGold, targetTierGold) || other.targetTierGold == targetTierGold)&&const DeepCollectionEquality().equals(other.productSpecificGoals, productSpecificGoals)&&(identical(other.targetCollectionPercentage, targetCollectionPercentage) || other.targetCollectionPercentage == targetCollectionPercentage)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mrUserId,periodType,startDate,endDate,targetSalesAmount,targetTierBronze,targetTierGold,const DeepCollectionEquality().hash(productSpecificGoals),targetCollectionPercentage,isLocked,createdAt,updatedAt);

@override
String toString() {
  return 'MrSalesTarget(id: $id, mrUserId: $mrUserId, periodType: $periodType, startDate: $startDate, endDate: $endDate, targetSalesAmount: $targetSalesAmount, targetTierBronze: $targetTierBronze, targetTierGold: $targetTierGold, productSpecificGoals: $productSpecificGoals, targetCollectionPercentage: $targetCollectionPercentage, isLocked: $isLocked, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $MrSalesTargetCopyWith<$Res>  {
  factory $MrSalesTargetCopyWith(MrSalesTarget value, $Res Function(MrSalesTarget) _then) = _$MrSalesTargetCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'mr_user_id') String mrUserId,@JsonKey(name: 'period_type') TargetPeriodType periodType,@JsonKey(name: 'start_date') DateTime startDate,@JsonKey(name: 'end_date') DateTime endDate,@JsonKey(name: 'target_sales_amount') double targetSalesAmount,@JsonKey(name: 'target_tier_bronze') double? targetTierBronze,@JsonKey(name: 'target_tier_gold') double? targetTierGold,@JsonKey(name: 'product_specific_goals') Map<String, dynamic>? productSpecificGoals,@JsonKey(name: 'target_collection_percentage') double? targetCollectionPercentage,@JsonKey(name: 'is_locked') bool isLocked,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class _$MrSalesTargetCopyWithImpl<$Res>
    implements $MrSalesTargetCopyWith<$Res> {
  _$MrSalesTargetCopyWithImpl(this._self, this._then);

  final MrSalesTarget _self;
  final $Res Function(MrSalesTarget) _then;

/// Create a copy of MrSalesTarget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? mrUserId = null,Object? periodType = null,Object? startDate = null,Object? endDate = null,Object? targetSalesAmount = null,Object? targetTierBronze = freezed,Object? targetTierGold = freezed,Object? productSpecificGoals = freezed,Object? targetCollectionPercentage = freezed,Object? isLocked = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mrUserId: null == mrUserId ? _self.mrUserId : mrUserId // ignore: cast_nullable_to_non_nullable
as String,periodType: null == periodType ? _self.periodType : periodType // ignore: cast_nullable_to_non_nullable
as TargetPeriodType,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,targetSalesAmount: null == targetSalesAmount ? _self.targetSalesAmount : targetSalesAmount // ignore: cast_nullable_to_non_nullable
as double,targetTierBronze: freezed == targetTierBronze ? _self.targetTierBronze : targetTierBronze // ignore: cast_nullable_to_non_nullable
as double?,targetTierGold: freezed == targetTierGold ? _self.targetTierGold : targetTierGold // ignore: cast_nullable_to_non_nullable
as double?,productSpecificGoals: freezed == productSpecificGoals ? _self.productSpecificGoals : productSpecificGoals // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,targetCollectionPercentage: freezed == targetCollectionPercentage ? _self.targetCollectionPercentage : targetCollectionPercentage // ignore: cast_nullable_to_non_nullable
as double?,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MrSalesTarget extends MrSalesTarget {
  const _MrSalesTarget({required this.id, @JsonKey(name: 'mr_user_id') required this.mrUserId, @JsonKey(name: 'period_type') required this.periodType, @JsonKey(name: 'start_date') required this.startDate, @JsonKey(name: 'end_date') required this.endDate, @JsonKey(name: 'target_sales_amount') required this.targetSalesAmount, @JsonKey(name: 'target_tier_bronze') this.targetTierBronze, @JsonKey(name: 'target_tier_gold') this.targetTierGold, @JsonKey(name: 'product_specific_goals') final  Map<String, dynamic>? productSpecificGoals, @JsonKey(name: 'target_collection_percentage') this.targetCollectionPercentage, @JsonKey(name: 'is_locked') this.isLocked = false, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt}): _productSpecificGoals = productSpecificGoals,super._();
  factory _MrSalesTarget.fromJson(Map<String, dynamic> json) => _$MrSalesTargetFromJson(json);

@override final  String id;
@override@JsonKey(name: 'mr_user_id') final  String mrUserId;
@override@JsonKey(name: 'period_type') final  TargetPeriodType periodType;
@override@JsonKey(name: 'start_date') final  DateTime startDate;
@override@JsonKey(name: 'end_date') final  DateTime endDate;
@override@JsonKey(name: 'target_sales_amount') final  double targetSalesAmount;
@override@JsonKey(name: 'target_tier_bronze') final  double? targetTierBronze;
@override@JsonKey(name: 'target_tier_gold') final  double? targetTierGold;
 final  Map<String, dynamic>? _productSpecificGoals;
@override@JsonKey(name: 'product_specific_goals') Map<String, dynamic>? get productSpecificGoals {
  final value = _productSpecificGoals;
  if (value == null) return null;
  if (_productSpecificGoals is EqualUnmodifiableMapView) return _productSpecificGoals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey(name: 'target_collection_percentage') final  double? targetCollectionPercentage;
@override@JsonKey(name: 'is_locked') final  bool isLocked;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

/// Create a copy of MrSalesTarget
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MrSalesTargetCopyWith<_MrSalesTarget> get copyWith => __$MrSalesTargetCopyWithImpl<_MrSalesTarget>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MrSalesTargetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MrSalesTarget&&(identical(other.id, id) || other.id == id)&&(identical(other.mrUserId, mrUserId) || other.mrUserId == mrUserId)&&(identical(other.periodType, periodType) || other.periodType == periodType)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.targetSalesAmount, targetSalesAmount) || other.targetSalesAmount == targetSalesAmount)&&(identical(other.targetTierBronze, targetTierBronze) || other.targetTierBronze == targetTierBronze)&&(identical(other.targetTierGold, targetTierGold) || other.targetTierGold == targetTierGold)&&const DeepCollectionEquality().equals(other._productSpecificGoals, _productSpecificGoals)&&(identical(other.targetCollectionPercentage, targetCollectionPercentage) || other.targetCollectionPercentage == targetCollectionPercentage)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mrUserId,periodType,startDate,endDate,targetSalesAmount,targetTierBronze,targetTierGold,const DeepCollectionEquality().hash(_productSpecificGoals),targetCollectionPercentage,isLocked,createdAt,updatedAt);

@override
String toString() {
  return 'MrSalesTarget(id: $id, mrUserId: $mrUserId, periodType: $periodType, startDate: $startDate, endDate: $endDate, targetSalesAmount: $targetSalesAmount, targetTierBronze: $targetTierBronze, targetTierGold: $targetTierGold, productSpecificGoals: $productSpecificGoals, targetCollectionPercentage: $targetCollectionPercentage, isLocked: $isLocked, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$MrSalesTargetCopyWith<$Res> implements $MrSalesTargetCopyWith<$Res> {
  factory _$MrSalesTargetCopyWith(_MrSalesTarget value, $Res Function(_MrSalesTarget) _then) = __$MrSalesTargetCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'mr_user_id') String mrUserId,@JsonKey(name: 'period_type') TargetPeriodType periodType,@JsonKey(name: 'start_date') DateTime startDate,@JsonKey(name: 'end_date') DateTime endDate,@JsonKey(name: 'target_sales_amount') double targetSalesAmount,@JsonKey(name: 'target_tier_bronze') double? targetTierBronze,@JsonKey(name: 'target_tier_gold') double? targetTierGold,@JsonKey(name: 'product_specific_goals') Map<String, dynamic>? productSpecificGoals,@JsonKey(name: 'target_collection_percentage') double? targetCollectionPercentage,@JsonKey(name: 'is_locked') bool isLocked,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class __$MrSalesTargetCopyWithImpl<$Res>
    implements _$MrSalesTargetCopyWith<$Res> {
  __$MrSalesTargetCopyWithImpl(this._self, this._then);

  final _MrSalesTarget _self;
  final $Res Function(_MrSalesTarget) _then;

/// Create a copy of MrSalesTarget
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mrUserId = null,Object? periodType = null,Object? startDate = null,Object? endDate = null,Object? targetSalesAmount = null,Object? targetTierBronze = freezed,Object? targetTierGold = freezed,Object? productSpecificGoals = freezed,Object? targetCollectionPercentage = freezed,Object? isLocked = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_MrSalesTarget(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mrUserId: null == mrUserId ? _self.mrUserId : mrUserId // ignore: cast_nullable_to_non_nullable
as String,periodType: null == periodType ? _self.periodType : periodType // ignore: cast_nullable_to_non_nullable
as TargetPeriodType,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,targetSalesAmount: null == targetSalesAmount ? _self.targetSalesAmount : targetSalesAmount // ignore: cast_nullable_to_non_nullable
as double,targetTierBronze: freezed == targetTierBronze ? _self.targetTierBronze : targetTierBronze // ignore: cast_nullable_to_non_nullable
as double?,targetTierGold: freezed == targetTierGold ? _self.targetTierGold : targetTierGold // ignore: cast_nullable_to_non_nullable
as double?,productSpecificGoals: freezed == productSpecificGoals ? _self._productSpecificGoals : productSpecificGoals // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,targetCollectionPercentage: freezed == targetCollectionPercentage ? _self.targetCollectionPercentage : targetCollectionPercentage // ignore: cast_nullable_to_non_nullable
as double?,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$ProductSpecificGoal {

 String get type;// 'product' or 'category'
 String get id; int? get goalUnits; double? get goalAmount;
/// Create a copy of ProductSpecificGoal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductSpecificGoalCopyWith<ProductSpecificGoal> get copyWith => _$ProductSpecificGoalCopyWithImpl<ProductSpecificGoal>(this as ProductSpecificGoal, _$identity);

  /// Serializes this ProductSpecificGoal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductSpecificGoal&&(identical(other.type, type) || other.type == type)&&(identical(other.id, id) || other.id == id)&&(identical(other.goalUnits, goalUnits) || other.goalUnits == goalUnits)&&(identical(other.goalAmount, goalAmount) || other.goalAmount == goalAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,id,goalUnits,goalAmount);

@override
String toString() {
  return 'ProductSpecificGoal(type: $type, id: $id, goalUnits: $goalUnits, goalAmount: $goalAmount)';
}


}

/// @nodoc
abstract mixin class $ProductSpecificGoalCopyWith<$Res>  {
  factory $ProductSpecificGoalCopyWith(ProductSpecificGoal value, $Res Function(ProductSpecificGoal) _then) = _$ProductSpecificGoalCopyWithImpl;
@useResult
$Res call({
 String type, String id, int? goalUnits, double? goalAmount
});




}
/// @nodoc
class _$ProductSpecificGoalCopyWithImpl<$Res>
    implements $ProductSpecificGoalCopyWith<$Res> {
  _$ProductSpecificGoalCopyWithImpl(this._self, this._then);

  final ProductSpecificGoal _self;
  final $Res Function(ProductSpecificGoal) _then;

/// Create a copy of ProductSpecificGoal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? id = null,Object? goalUnits = freezed,Object? goalAmount = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,goalUnits: freezed == goalUnits ? _self.goalUnits : goalUnits // ignore: cast_nullable_to_non_nullable
as int?,goalAmount: freezed == goalAmount ? _self.goalAmount : goalAmount // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ProductSpecificGoal extends ProductSpecificGoal {
  const _ProductSpecificGoal({required this.type, required this.id, this.goalUnits, this.goalAmount}): super._();
  factory _ProductSpecificGoal.fromJson(Map<String, dynamic> json) => _$ProductSpecificGoalFromJson(json);

@override final  String type;
// 'product' or 'category'
@override final  String id;
@override final  int? goalUnits;
@override final  double? goalAmount;

/// Create a copy of ProductSpecificGoal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductSpecificGoalCopyWith<_ProductSpecificGoal> get copyWith => __$ProductSpecificGoalCopyWithImpl<_ProductSpecificGoal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductSpecificGoalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductSpecificGoal&&(identical(other.type, type) || other.type == type)&&(identical(other.id, id) || other.id == id)&&(identical(other.goalUnits, goalUnits) || other.goalUnits == goalUnits)&&(identical(other.goalAmount, goalAmount) || other.goalAmount == goalAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,id,goalUnits,goalAmount);

@override
String toString() {
  return 'ProductSpecificGoal(type: $type, id: $id, goalUnits: $goalUnits, goalAmount: $goalAmount)';
}


}

/// @nodoc
abstract mixin class _$ProductSpecificGoalCopyWith<$Res> implements $ProductSpecificGoalCopyWith<$Res> {
  factory _$ProductSpecificGoalCopyWith(_ProductSpecificGoal value, $Res Function(_ProductSpecificGoal) _then) = __$ProductSpecificGoalCopyWithImpl;
@override @useResult
$Res call({
 String type, String id, int? goalUnits, double? goalAmount
});




}
/// @nodoc
class __$ProductSpecificGoalCopyWithImpl<$Res>
    implements _$ProductSpecificGoalCopyWith<$Res> {
  __$ProductSpecificGoalCopyWithImpl(this._self, this._then);

  final _ProductSpecificGoal _self;
  final $Res Function(_ProductSpecificGoal) _then;

/// Create a copy of ProductSpecificGoal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? id = null,Object? goalUnits = freezed,Object? goalAmount = freezed,}) {
  return _then(_ProductSpecificGoal(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,goalUnits: freezed == goalUnits ? _self.goalUnits : goalUnits // ignore: cast_nullable_to_non_nullable
as int?,goalAmount: freezed == goalAmount ? _self.goalAmount : goalAmount // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$DashboardData {

 MrSalesTarget? get target; double get totalSalesAmount; double get totalCollectedAmount; List<MrSalesOrder> get recentSales; ProductGoalProgress? get focusGoalProgress;
/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardDataCopyWith<DashboardData> get copyWith => _$DashboardDataCopyWithImpl<DashboardData>(this as DashboardData, _$identity);

  /// Serializes this DashboardData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardData&&(identical(other.target, target) || other.target == target)&&(identical(other.totalSalesAmount, totalSalesAmount) || other.totalSalesAmount == totalSalesAmount)&&(identical(other.totalCollectedAmount, totalCollectedAmount) || other.totalCollectedAmount == totalCollectedAmount)&&const DeepCollectionEquality().equals(other.recentSales, recentSales)&&(identical(other.focusGoalProgress, focusGoalProgress) || other.focusGoalProgress == focusGoalProgress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,target,totalSalesAmount,totalCollectedAmount,const DeepCollectionEquality().hash(recentSales),focusGoalProgress);

@override
String toString() {
  return 'DashboardData(target: $target, totalSalesAmount: $totalSalesAmount, totalCollectedAmount: $totalCollectedAmount, recentSales: $recentSales, focusGoalProgress: $focusGoalProgress)';
}


}

/// @nodoc
abstract mixin class $DashboardDataCopyWith<$Res>  {
  factory $DashboardDataCopyWith(DashboardData value, $Res Function(DashboardData) _then) = _$DashboardDataCopyWithImpl;
@useResult
$Res call({
 MrSalesTarget? target, double totalSalesAmount, double totalCollectedAmount, List<MrSalesOrder> recentSales, ProductGoalProgress? focusGoalProgress
});


$MrSalesTargetCopyWith<$Res>? get target;$ProductGoalProgressCopyWith<$Res>? get focusGoalProgress;

}
/// @nodoc
class _$DashboardDataCopyWithImpl<$Res>
    implements $DashboardDataCopyWith<$Res> {
  _$DashboardDataCopyWithImpl(this._self, this._then);

  final DashboardData _self;
  final $Res Function(DashboardData) _then;

/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? target = freezed,Object? totalSalesAmount = null,Object? totalCollectedAmount = null,Object? recentSales = null,Object? focusGoalProgress = freezed,}) {
  return _then(_self.copyWith(
target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as MrSalesTarget?,totalSalesAmount: null == totalSalesAmount ? _self.totalSalesAmount : totalSalesAmount // ignore: cast_nullable_to_non_nullable
as double,totalCollectedAmount: null == totalCollectedAmount ? _self.totalCollectedAmount : totalCollectedAmount // ignore: cast_nullable_to_non_nullable
as double,recentSales: null == recentSales ? _self.recentSales : recentSales // ignore: cast_nullable_to_non_nullable
as List<MrSalesOrder>,focusGoalProgress: freezed == focusGoalProgress ? _self.focusGoalProgress : focusGoalProgress // ignore: cast_nullable_to_non_nullable
as ProductGoalProgress?,
  ));
}
/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MrSalesTargetCopyWith<$Res>? get target {
    if (_self.target == null) {
    return null;
  }

  return $MrSalesTargetCopyWith<$Res>(_self.target!, (value) {
    return _then(_self.copyWith(target: value));
  });
}/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductGoalProgressCopyWith<$Res>? get focusGoalProgress {
    if (_self.focusGoalProgress == null) {
    return null;
  }

  return $ProductGoalProgressCopyWith<$Res>(_self.focusGoalProgress!, (value) {
    return _then(_self.copyWith(focusGoalProgress: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _DashboardData extends DashboardData {
  const _DashboardData({this.target, required this.totalSalesAmount, required this.totalCollectedAmount, required final  List<MrSalesOrder> recentSales, this.focusGoalProgress}): _recentSales = recentSales,super._();
  factory _DashboardData.fromJson(Map<String, dynamic> json) => _$DashboardDataFromJson(json);

@override final  MrSalesTarget? target;
@override final  double totalSalesAmount;
@override final  double totalCollectedAmount;
 final  List<MrSalesOrder> _recentSales;
@override List<MrSalesOrder> get recentSales {
  if (_recentSales is EqualUnmodifiableListView) return _recentSales;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentSales);
}

@override final  ProductGoalProgress? focusGoalProgress;

/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardDataCopyWith<_DashboardData> get copyWith => __$DashboardDataCopyWithImpl<_DashboardData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardData&&(identical(other.target, target) || other.target == target)&&(identical(other.totalSalesAmount, totalSalesAmount) || other.totalSalesAmount == totalSalesAmount)&&(identical(other.totalCollectedAmount, totalCollectedAmount) || other.totalCollectedAmount == totalCollectedAmount)&&const DeepCollectionEquality().equals(other._recentSales, _recentSales)&&(identical(other.focusGoalProgress, focusGoalProgress) || other.focusGoalProgress == focusGoalProgress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,target,totalSalesAmount,totalCollectedAmount,const DeepCollectionEquality().hash(_recentSales),focusGoalProgress);

@override
String toString() {
  return 'DashboardData(target: $target, totalSalesAmount: $totalSalesAmount, totalCollectedAmount: $totalCollectedAmount, recentSales: $recentSales, focusGoalProgress: $focusGoalProgress)';
}


}

/// @nodoc
abstract mixin class _$DashboardDataCopyWith<$Res> implements $DashboardDataCopyWith<$Res> {
  factory _$DashboardDataCopyWith(_DashboardData value, $Res Function(_DashboardData) _then) = __$DashboardDataCopyWithImpl;
@override @useResult
$Res call({
 MrSalesTarget? target, double totalSalesAmount, double totalCollectedAmount, List<MrSalesOrder> recentSales, ProductGoalProgress? focusGoalProgress
});


@override $MrSalesTargetCopyWith<$Res>? get target;@override $ProductGoalProgressCopyWith<$Res>? get focusGoalProgress;

}
/// @nodoc
class __$DashboardDataCopyWithImpl<$Res>
    implements _$DashboardDataCopyWith<$Res> {
  __$DashboardDataCopyWithImpl(this._self, this._then);

  final _DashboardData _self;
  final $Res Function(_DashboardData) _then;

/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? target = freezed,Object? totalSalesAmount = null,Object? totalCollectedAmount = null,Object? recentSales = null,Object? focusGoalProgress = freezed,}) {
  return _then(_DashboardData(
target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as MrSalesTarget?,totalSalesAmount: null == totalSalesAmount ? _self.totalSalesAmount : totalSalesAmount // ignore: cast_nullable_to_non_nullable
as double,totalCollectedAmount: null == totalCollectedAmount ? _self.totalCollectedAmount : totalCollectedAmount // ignore: cast_nullable_to_non_nullable
as double,recentSales: null == recentSales ? _self._recentSales : recentSales // ignore: cast_nullable_to_non_nullable
as List<MrSalesOrder>,focusGoalProgress: freezed == focusGoalProgress ? _self.focusGoalProgress : focusGoalProgress // ignore: cast_nullable_to_non_nullable
as ProductGoalProgress?,
  ));
}

/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MrSalesTargetCopyWith<$Res>? get target {
    if (_self.target == null) {
    return null;
  }

  return $MrSalesTargetCopyWith<$Res>(_self.target!, (value) {
    return _then(_self.copyWith(target: value));
  });
}/// Create a copy of DashboardData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductGoalProgressCopyWith<$Res>? get focusGoalProgress {
    if (_self.focusGoalProgress == null) {
    return null;
  }

  return $ProductGoalProgressCopyWith<$Res>(_self.focusGoalProgress!, (value) {
    return _then(_self.copyWith(focusGoalProgress: value));
  });
}
}


/// @nodoc
mixin _$ProductGoalProgress {

 String get productName; int get currentUnits; int get targetUnits; double? get currentAmount; double? get targetAmount;
/// Create a copy of ProductGoalProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductGoalProgressCopyWith<ProductGoalProgress> get copyWith => _$ProductGoalProgressCopyWithImpl<ProductGoalProgress>(this as ProductGoalProgress, _$identity);

  /// Serializes this ProductGoalProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductGoalProgress&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.currentUnits, currentUnits) || other.currentUnits == currentUnits)&&(identical(other.targetUnits, targetUnits) || other.targetUnits == targetUnits)&&(identical(other.currentAmount, currentAmount) || other.currentAmount == currentAmount)&&(identical(other.targetAmount, targetAmount) || other.targetAmount == targetAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productName,currentUnits,targetUnits,currentAmount,targetAmount);

@override
String toString() {
  return 'ProductGoalProgress(productName: $productName, currentUnits: $currentUnits, targetUnits: $targetUnits, currentAmount: $currentAmount, targetAmount: $targetAmount)';
}


}

/// @nodoc
abstract mixin class $ProductGoalProgressCopyWith<$Res>  {
  factory $ProductGoalProgressCopyWith(ProductGoalProgress value, $Res Function(ProductGoalProgress) _then) = _$ProductGoalProgressCopyWithImpl;
@useResult
$Res call({
 String productName, int currentUnits, int targetUnits, double? currentAmount, double? targetAmount
});




}
/// @nodoc
class _$ProductGoalProgressCopyWithImpl<$Res>
    implements $ProductGoalProgressCopyWith<$Res> {
  _$ProductGoalProgressCopyWithImpl(this._self, this._then);

  final ProductGoalProgress _self;
  final $Res Function(ProductGoalProgress) _then;

/// Create a copy of ProductGoalProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productName = null,Object? currentUnits = null,Object? targetUnits = null,Object? currentAmount = freezed,Object? targetAmount = freezed,}) {
  return _then(_self.copyWith(
productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,currentUnits: null == currentUnits ? _self.currentUnits : currentUnits // ignore: cast_nullable_to_non_nullable
as int,targetUnits: null == targetUnits ? _self.targetUnits : targetUnits // ignore: cast_nullable_to_non_nullable
as int,currentAmount: freezed == currentAmount ? _self.currentAmount : currentAmount // ignore: cast_nullable_to_non_nullable
as double?,targetAmount: freezed == targetAmount ? _self.targetAmount : targetAmount // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ProductGoalProgress extends ProductGoalProgress {
  const _ProductGoalProgress({required this.productName, required this.currentUnits, required this.targetUnits, this.currentAmount, this.targetAmount}): super._();
  factory _ProductGoalProgress.fromJson(Map<String, dynamic> json) => _$ProductGoalProgressFromJson(json);

@override final  String productName;
@override final  int currentUnits;
@override final  int targetUnits;
@override final  double? currentAmount;
@override final  double? targetAmount;

/// Create a copy of ProductGoalProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductGoalProgressCopyWith<_ProductGoalProgress> get copyWith => __$ProductGoalProgressCopyWithImpl<_ProductGoalProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductGoalProgressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductGoalProgress&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.currentUnits, currentUnits) || other.currentUnits == currentUnits)&&(identical(other.targetUnits, targetUnits) || other.targetUnits == targetUnits)&&(identical(other.currentAmount, currentAmount) || other.currentAmount == currentAmount)&&(identical(other.targetAmount, targetAmount) || other.targetAmount == targetAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productName,currentUnits,targetUnits,currentAmount,targetAmount);

@override
String toString() {
  return 'ProductGoalProgress(productName: $productName, currentUnits: $currentUnits, targetUnits: $targetUnits, currentAmount: $currentAmount, targetAmount: $targetAmount)';
}


}

/// @nodoc
abstract mixin class _$ProductGoalProgressCopyWith<$Res> implements $ProductGoalProgressCopyWith<$Res> {
  factory _$ProductGoalProgressCopyWith(_ProductGoalProgress value, $Res Function(_ProductGoalProgress) _then) = __$ProductGoalProgressCopyWithImpl;
@override @useResult
$Res call({
 String productName, int currentUnits, int targetUnits, double? currentAmount, double? targetAmount
});




}
/// @nodoc
class __$ProductGoalProgressCopyWithImpl<$Res>
    implements _$ProductGoalProgressCopyWith<$Res> {
  __$ProductGoalProgressCopyWithImpl(this._self, this._then);

  final _ProductGoalProgress _self;
  final $Res Function(_ProductGoalProgress) _then;

/// Create a copy of ProductGoalProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productName = null,Object? currentUnits = null,Object? targetUnits = null,Object? currentAmount = freezed,Object? targetAmount = freezed,}) {
  return _then(_ProductGoalProgress(
productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,currentUnits: null == currentUnits ? _self.currentUnits : currentUnits // ignore: cast_nullable_to_non_nullable
as int,targetUnits: null == targetUnits ? _self.targetUnits : targetUnits // ignore: cast_nullable_to_non_nullable
as int,currentAmount: freezed == currentAmount ? _self.currentAmount : currentAmount // ignore: cast_nullable_to_non_nullable
as double?,targetAmount: freezed == targetAmount ? _self.targetAmount : targetAmount // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$TargetFormData {

 double get mainGoal; double get bronzeGoal; double get goldGoal; double get collectionPercentage; String? get focusProductId; String? get focusProductName; int get focusGoalUnits; double get focusGoalAmount; String get focusType;
/// Create a copy of TargetFormData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TargetFormDataCopyWith<TargetFormData> get copyWith => _$TargetFormDataCopyWithImpl<TargetFormData>(this as TargetFormData, _$identity);

  /// Serializes this TargetFormData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TargetFormData&&(identical(other.mainGoal, mainGoal) || other.mainGoal == mainGoal)&&(identical(other.bronzeGoal, bronzeGoal) || other.bronzeGoal == bronzeGoal)&&(identical(other.goldGoal, goldGoal) || other.goldGoal == goldGoal)&&(identical(other.collectionPercentage, collectionPercentage) || other.collectionPercentage == collectionPercentage)&&(identical(other.focusProductId, focusProductId) || other.focusProductId == focusProductId)&&(identical(other.focusProductName, focusProductName) || other.focusProductName == focusProductName)&&(identical(other.focusGoalUnits, focusGoalUnits) || other.focusGoalUnits == focusGoalUnits)&&(identical(other.focusGoalAmount, focusGoalAmount) || other.focusGoalAmount == focusGoalAmount)&&(identical(other.focusType, focusType) || other.focusType == focusType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mainGoal,bronzeGoal,goldGoal,collectionPercentage,focusProductId,focusProductName,focusGoalUnits,focusGoalAmount,focusType);

@override
String toString() {
  return 'TargetFormData(mainGoal: $mainGoal, bronzeGoal: $bronzeGoal, goldGoal: $goldGoal, collectionPercentage: $collectionPercentage, focusProductId: $focusProductId, focusProductName: $focusProductName, focusGoalUnits: $focusGoalUnits, focusGoalAmount: $focusGoalAmount, focusType: $focusType)';
}


}

/// @nodoc
abstract mixin class $TargetFormDataCopyWith<$Res>  {
  factory $TargetFormDataCopyWith(TargetFormData value, $Res Function(TargetFormData) _then) = _$TargetFormDataCopyWithImpl;
@useResult
$Res call({
 double mainGoal, double bronzeGoal, double goldGoal, double collectionPercentage, String? focusProductId, String? focusProductName, int focusGoalUnits, double focusGoalAmount, String focusType
});




}
/// @nodoc
class _$TargetFormDataCopyWithImpl<$Res>
    implements $TargetFormDataCopyWith<$Res> {
  _$TargetFormDataCopyWithImpl(this._self, this._then);

  final TargetFormData _self;
  final $Res Function(TargetFormData) _then;

/// Create a copy of TargetFormData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mainGoal = null,Object? bronzeGoal = null,Object? goldGoal = null,Object? collectionPercentage = null,Object? focusProductId = freezed,Object? focusProductName = freezed,Object? focusGoalUnits = null,Object? focusGoalAmount = null,Object? focusType = null,}) {
  return _then(_self.copyWith(
mainGoal: null == mainGoal ? _self.mainGoal : mainGoal // ignore: cast_nullable_to_non_nullable
as double,bronzeGoal: null == bronzeGoal ? _self.bronzeGoal : bronzeGoal // ignore: cast_nullable_to_non_nullable
as double,goldGoal: null == goldGoal ? _self.goldGoal : goldGoal // ignore: cast_nullable_to_non_nullable
as double,collectionPercentage: null == collectionPercentage ? _self.collectionPercentage : collectionPercentage // ignore: cast_nullable_to_non_nullable
as double,focusProductId: freezed == focusProductId ? _self.focusProductId : focusProductId // ignore: cast_nullable_to_non_nullable
as String?,focusProductName: freezed == focusProductName ? _self.focusProductName : focusProductName // ignore: cast_nullable_to_non_nullable
as String?,focusGoalUnits: null == focusGoalUnits ? _self.focusGoalUnits : focusGoalUnits // ignore: cast_nullable_to_non_nullable
as int,focusGoalAmount: null == focusGoalAmount ? _self.focusGoalAmount : focusGoalAmount // ignore: cast_nullable_to_non_nullable
as double,focusType: null == focusType ? _self.focusType : focusType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TargetFormData extends TargetFormData {
  const _TargetFormData({this.mainGoal = 0.0, this.bronzeGoal = 0.0, this.goldGoal = 0.0, this.collectionPercentage = 0.0, this.focusProductId, this.focusProductName, this.focusGoalUnits = 0, this.focusGoalAmount = 0.0, this.focusType = 'product'}): super._();
  factory _TargetFormData.fromJson(Map<String, dynamic> json) => _$TargetFormDataFromJson(json);

@override@JsonKey() final  double mainGoal;
@override@JsonKey() final  double bronzeGoal;
@override@JsonKey() final  double goldGoal;
@override@JsonKey() final  double collectionPercentage;
@override final  String? focusProductId;
@override final  String? focusProductName;
@override@JsonKey() final  int focusGoalUnits;
@override@JsonKey() final  double focusGoalAmount;
@override@JsonKey() final  String focusType;

/// Create a copy of TargetFormData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TargetFormDataCopyWith<_TargetFormData> get copyWith => __$TargetFormDataCopyWithImpl<_TargetFormData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TargetFormDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TargetFormData&&(identical(other.mainGoal, mainGoal) || other.mainGoal == mainGoal)&&(identical(other.bronzeGoal, bronzeGoal) || other.bronzeGoal == bronzeGoal)&&(identical(other.goldGoal, goldGoal) || other.goldGoal == goldGoal)&&(identical(other.collectionPercentage, collectionPercentage) || other.collectionPercentage == collectionPercentage)&&(identical(other.focusProductId, focusProductId) || other.focusProductId == focusProductId)&&(identical(other.focusProductName, focusProductName) || other.focusProductName == focusProductName)&&(identical(other.focusGoalUnits, focusGoalUnits) || other.focusGoalUnits == focusGoalUnits)&&(identical(other.focusGoalAmount, focusGoalAmount) || other.focusGoalAmount == focusGoalAmount)&&(identical(other.focusType, focusType) || other.focusType == focusType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mainGoal,bronzeGoal,goldGoal,collectionPercentage,focusProductId,focusProductName,focusGoalUnits,focusGoalAmount,focusType);

@override
String toString() {
  return 'TargetFormData(mainGoal: $mainGoal, bronzeGoal: $bronzeGoal, goldGoal: $goldGoal, collectionPercentage: $collectionPercentage, focusProductId: $focusProductId, focusProductName: $focusProductName, focusGoalUnits: $focusGoalUnits, focusGoalAmount: $focusGoalAmount, focusType: $focusType)';
}


}

/// @nodoc
abstract mixin class _$TargetFormDataCopyWith<$Res> implements $TargetFormDataCopyWith<$Res> {
  factory _$TargetFormDataCopyWith(_TargetFormData value, $Res Function(_TargetFormData) _then) = __$TargetFormDataCopyWithImpl;
@override @useResult
$Res call({
 double mainGoal, double bronzeGoal, double goldGoal, double collectionPercentage, String? focusProductId, String? focusProductName, int focusGoalUnits, double focusGoalAmount, String focusType
});




}
/// @nodoc
class __$TargetFormDataCopyWithImpl<$Res>
    implements _$TargetFormDataCopyWith<$Res> {
  __$TargetFormDataCopyWithImpl(this._self, this._then);

  final _TargetFormData _self;
  final $Res Function(_TargetFormData) _then;

/// Create a copy of TargetFormData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mainGoal = null,Object? bronzeGoal = null,Object? goldGoal = null,Object? collectionPercentage = null,Object? focusProductId = freezed,Object? focusProductName = freezed,Object? focusGoalUnits = null,Object? focusGoalAmount = null,Object? focusType = null,}) {
  return _then(_TargetFormData(
mainGoal: null == mainGoal ? _self.mainGoal : mainGoal // ignore: cast_nullable_to_non_nullable
as double,bronzeGoal: null == bronzeGoal ? _self.bronzeGoal : bronzeGoal // ignore: cast_nullable_to_non_nullable
as double,goldGoal: null == goldGoal ? _self.goldGoal : goldGoal // ignore: cast_nullable_to_non_nullable
as double,collectionPercentage: null == collectionPercentage ? _self.collectionPercentage : collectionPercentage // ignore: cast_nullable_to_non_nullable
as double,focusProductId: freezed == focusProductId ? _self.focusProductId : focusProductId // ignore: cast_nullable_to_non_nullable
as String?,focusProductName: freezed == focusProductName ? _self.focusProductName : focusProductName // ignore: cast_nullable_to_non_nullable
as String?,focusGoalUnits: null == focusGoalUnits ? _self.focusGoalUnits : focusGoalUnits // ignore: cast_nullable_to_non_nullable
as int,focusGoalAmount: null == focusGoalAmount ? _self.focusGoalAmount : focusGoalAmount // ignore: cast_nullable_to_non_nullable
as double,focusType: null == focusType ? _self.focusType : focusType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

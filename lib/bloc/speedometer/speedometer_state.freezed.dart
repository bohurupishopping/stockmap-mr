// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'speedometer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SpeedometerState {

 String get selectedPeriod;
/// Create a copy of SpeedometerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeedometerStateCopyWith<SpeedometerState> get copyWith => _$SpeedometerStateCopyWithImpl<SpeedometerState>(this as SpeedometerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeedometerState&&(identical(other.selectedPeriod, selectedPeriod) || other.selectedPeriod == selectedPeriod));
}


@override
int get hashCode => Object.hash(runtimeType,selectedPeriod);

@override
String toString() {
  return 'SpeedometerState(selectedPeriod: $selectedPeriod)';
}


}

/// @nodoc
abstract mixin class $SpeedometerStateCopyWith<$Res>  {
  factory $SpeedometerStateCopyWith(SpeedometerState value, $Res Function(SpeedometerState) _then) = _$SpeedometerStateCopyWithImpl;
@useResult
$Res call({
 String selectedPeriod
});




}
/// @nodoc
class _$SpeedometerStateCopyWithImpl<$Res>
    implements $SpeedometerStateCopyWith<$Res> {
  _$SpeedometerStateCopyWithImpl(this._self, this._then);

  final SpeedometerState _self;
  final $Res Function(SpeedometerState) _then;

/// Create a copy of SpeedometerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedPeriod = null,}) {
  return _then(_self.copyWith(
selectedPeriod: null == selectedPeriod ? _self.selectedPeriod : selectedPeriod // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class SpeedometerInitial extends SpeedometerState {
  const SpeedometerInitial({this.selectedPeriod = 'This Month'}): super._();
  

@override@JsonKey() final  String selectedPeriod;

/// Create a copy of SpeedometerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeedometerInitialCopyWith<SpeedometerInitial> get copyWith => _$SpeedometerInitialCopyWithImpl<SpeedometerInitial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeedometerInitial&&(identical(other.selectedPeriod, selectedPeriod) || other.selectedPeriod == selectedPeriod));
}


@override
int get hashCode => Object.hash(runtimeType,selectedPeriod);

@override
String toString() {
  return 'SpeedometerState.initial(selectedPeriod: $selectedPeriod)';
}


}

/// @nodoc
abstract mixin class $SpeedometerInitialCopyWith<$Res> implements $SpeedometerStateCopyWith<$Res> {
  factory $SpeedometerInitialCopyWith(SpeedometerInitial value, $Res Function(SpeedometerInitial) _then) = _$SpeedometerInitialCopyWithImpl;
@override @useResult
$Res call({
 String selectedPeriod
});




}
/// @nodoc
class _$SpeedometerInitialCopyWithImpl<$Res>
    implements $SpeedometerInitialCopyWith<$Res> {
  _$SpeedometerInitialCopyWithImpl(this._self, this._then);

  final SpeedometerInitial _self;
  final $Res Function(SpeedometerInitial) _then;

/// Create a copy of SpeedometerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedPeriod = null,}) {
  return _then(SpeedometerInitial(
selectedPeriod: null == selectedPeriod ? _self.selectedPeriod : selectedPeriod // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SpeedometerLoading extends SpeedometerState {
  const SpeedometerLoading({required this.selectedPeriod}): super._();
  

@override final  String selectedPeriod;

/// Create a copy of SpeedometerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeedometerLoadingCopyWith<SpeedometerLoading> get copyWith => _$SpeedometerLoadingCopyWithImpl<SpeedometerLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeedometerLoading&&(identical(other.selectedPeriod, selectedPeriod) || other.selectedPeriod == selectedPeriod));
}


@override
int get hashCode => Object.hash(runtimeType,selectedPeriod);

@override
String toString() {
  return 'SpeedometerState.loading(selectedPeriod: $selectedPeriod)';
}


}

/// @nodoc
abstract mixin class $SpeedometerLoadingCopyWith<$Res> implements $SpeedometerStateCopyWith<$Res> {
  factory $SpeedometerLoadingCopyWith(SpeedometerLoading value, $Res Function(SpeedometerLoading) _then) = _$SpeedometerLoadingCopyWithImpl;
@override @useResult
$Res call({
 String selectedPeriod
});




}
/// @nodoc
class _$SpeedometerLoadingCopyWithImpl<$Res>
    implements $SpeedometerLoadingCopyWith<$Res> {
  _$SpeedometerLoadingCopyWithImpl(this._self, this._then);

  final SpeedometerLoading _self;
  final $Res Function(SpeedometerLoading) _then;

/// Create a copy of SpeedometerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedPeriod = null,}) {
  return _then(SpeedometerLoading(
selectedPeriod: null == selectedPeriod ? _self.selectedPeriod : selectedPeriod // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SpeedometerLoaded extends SpeedometerState {
  const SpeedometerLoaded({required this.selectedPeriod, required this.dashboardData}): super._();
  

@override final  String selectedPeriod;
 final  DashboardData dashboardData;

/// Create a copy of SpeedometerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeedometerLoadedCopyWith<SpeedometerLoaded> get copyWith => _$SpeedometerLoadedCopyWithImpl<SpeedometerLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeedometerLoaded&&(identical(other.selectedPeriod, selectedPeriod) || other.selectedPeriod == selectedPeriod)&&(identical(other.dashboardData, dashboardData) || other.dashboardData == dashboardData));
}


@override
int get hashCode => Object.hash(runtimeType,selectedPeriod,dashboardData);

@override
String toString() {
  return 'SpeedometerState.loaded(selectedPeriod: $selectedPeriod, dashboardData: $dashboardData)';
}


}

/// @nodoc
abstract mixin class $SpeedometerLoadedCopyWith<$Res> implements $SpeedometerStateCopyWith<$Res> {
  factory $SpeedometerLoadedCopyWith(SpeedometerLoaded value, $Res Function(SpeedometerLoaded) _then) = _$SpeedometerLoadedCopyWithImpl;
@override @useResult
$Res call({
 String selectedPeriod, DashboardData dashboardData
});


$DashboardDataCopyWith<$Res> get dashboardData;

}
/// @nodoc
class _$SpeedometerLoadedCopyWithImpl<$Res>
    implements $SpeedometerLoadedCopyWith<$Res> {
  _$SpeedometerLoadedCopyWithImpl(this._self, this._then);

  final SpeedometerLoaded _self;
  final $Res Function(SpeedometerLoaded) _then;

/// Create a copy of SpeedometerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedPeriod = null,Object? dashboardData = null,}) {
  return _then(SpeedometerLoaded(
selectedPeriod: null == selectedPeriod ? _self.selectedPeriod : selectedPeriod // ignore: cast_nullable_to_non_nullable
as String,dashboardData: null == dashboardData ? _self.dashboardData : dashboardData // ignore: cast_nullable_to_non_nullable
as DashboardData,
  ));
}

/// Create a copy of SpeedometerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardDataCopyWith<$Res> get dashboardData {
  
  return $DashboardDataCopyWith<$Res>(_self.dashboardData, (value) {
    return _then(_self.copyWith(dashboardData: value));
  });
}
}

/// @nodoc


class SpeedometerCreatingTarget extends SpeedometerState {
  const SpeedometerCreatingTarget({required this.selectedPeriod}): super._();
  

@override final  String selectedPeriod;

/// Create a copy of SpeedometerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeedometerCreatingTargetCopyWith<SpeedometerCreatingTarget> get copyWith => _$SpeedometerCreatingTargetCopyWithImpl<SpeedometerCreatingTarget>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeedometerCreatingTarget&&(identical(other.selectedPeriod, selectedPeriod) || other.selectedPeriod == selectedPeriod));
}


@override
int get hashCode => Object.hash(runtimeType,selectedPeriod);

@override
String toString() {
  return 'SpeedometerState.creatingTarget(selectedPeriod: $selectedPeriod)';
}


}

/// @nodoc
abstract mixin class $SpeedometerCreatingTargetCopyWith<$Res> implements $SpeedometerStateCopyWith<$Res> {
  factory $SpeedometerCreatingTargetCopyWith(SpeedometerCreatingTarget value, $Res Function(SpeedometerCreatingTarget) _then) = _$SpeedometerCreatingTargetCopyWithImpl;
@override @useResult
$Res call({
 String selectedPeriod
});




}
/// @nodoc
class _$SpeedometerCreatingTargetCopyWithImpl<$Res>
    implements $SpeedometerCreatingTargetCopyWith<$Res> {
  _$SpeedometerCreatingTargetCopyWithImpl(this._self, this._then);

  final SpeedometerCreatingTarget _self;
  final $Res Function(SpeedometerCreatingTarget) _then;

/// Create a copy of SpeedometerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedPeriod = null,}) {
  return _then(SpeedometerCreatingTarget(
selectedPeriod: null == selectedPeriod ? _self.selectedPeriod : selectedPeriod // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SpeedometerError extends SpeedometerState {
  const SpeedometerError({required this.selectedPeriod, required this.message}): super._();
  

@override final  String selectedPeriod;
 final  String message;

/// Create a copy of SpeedometerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeedometerErrorCopyWith<SpeedometerError> get copyWith => _$SpeedometerErrorCopyWithImpl<SpeedometerError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeedometerError&&(identical(other.selectedPeriod, selectedPeriod) || other.selectedPeriod == selectedPeriod)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,selectedPeriod,message);

@override
String toString() {
  return 'SpeedometerState.error(selectedPeriod: $selectedPeriod, message: $message)';
}


}

/// @nodoc
abstract mixin class $SpeedometerErrorCopyWith<$Res> implements $SpeedometerStateCopyWith<$Res> {
  factory $SpeedometerErrorCopyWith(SpeedometerError value, $Res Function(SpeedometerError) _then) = _$SpeedometerErrorCopyWithImpl;
@override @useResult
$Res call({
 String selectedPeriod, String message
});




}
/// @nodoc
class _$SpeedometerErrorCopyWithImpl<$Res>
    implements $SpeedometerErrorCopyWith<$Res> {
  _$SpeedometerErrorCopyWithImpl(this._self, this._then);

  final SpeedometerError _self;
  final $Res Function(SpeedometerError) _then;

/// Create a copy of SpeedometerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedPeriod = null,Object? message = null,}) {
  return _then(SpeedometerError(
selectedPeriod: null == selectedPeriod ? _self.selectedPeriod : selectedPeriod // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

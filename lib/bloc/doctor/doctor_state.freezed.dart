// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doctor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DoctorState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DoctorState()';
}


}

/// @nodoc
class $DoctorStateCopyWith<$Res>  {
$DoctorStateCopyWith(DoctorState _, $Res Function(DoctorState) __);
}


/// @nodoc


class DoctorInitial implements DoctorState {
  const DoctorInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DoctorState.initial()';
}


}




/// @nodoc


class DoctorLoading implements DoctorState {
  const DoctorLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DoctorState.loading()';
}


}




/// @nodoc


class DoctorLoaded implements DoctorState {
  const DoctorLoaded({required final  List<Doctor> doctors, this.searchQuery = ''}): _doctors = doctors;
  

 final  List<Doctor> _doctors;
 List<Doctor> get doctors {
  if (_doctors is EqualUnmodifiableListView) return _doctors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_doctors);
}

@JsonKey() final  String searchQuery;

/// Create a copy of DoctorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoctorLoadedCopyWith<DoctorLoaded> get copyWith => _$DoctorLoadedCopyWithImpl<DoctorLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorLoaded&&const DeepCollectionEquality().equals(other._doctors, _doctors)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_doctors),searchQuery);

@override
String toString() {
  return 'DoctorState.loaded(doctors: $doctors, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class $DoctorLoadedCopyWith<$Res> implements $DoctorStateCopyWith<$Res> {
  factory $DoctorLoadedCopyWith(DoctorLoaded value, $Res Function(DoctorLoaded) _then) = _$DoctorLoadedCopyWithImpl;
@useResult
$Res call({
 List<Doctor> doctors, String searchQuery
});




}
/// @nodoc
class _$DoctorLoadedCopyWithImpl<$Res>
    implements $DoctorLoadedCopyWith<$Res> {
  _$DoctorLoadedCopyWithImpl(this._self, this._then);

  final DoctorLoaded _self;
  final $Res Function(DoctorLoaded) _then;

/// Create a copy of DoctorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? doctors = null,Object? searchQuery = null,}) {
  return _then(DoctorLoaded(
doctors: null == doctors ? _self._doctors : doctors // ignore: cast_nullable_to_non_nullable
as List<Doctor>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class DoctorError implements DoctorState {
  const DoctorError({required this.message});
  

 final  String message;

/// Create a copy of DoctorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoctorErrorCopyWith<DoctorError> get copyWith => _$DoctorErrorCopyWithImpl<DoctorError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'DoctorState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $DoctorErrorCopyWith<$Res> implements $DoctorStateCopyWith<$Res> {
  factory $DoctorErrorCopyWith(DoctorError value, $Res Function(DoctorError) _then) = _$DoctorErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$DoctorErrorCopyWithImpl<$Res>
    implements $DoctorErrorCopyWith<$Res> {
  _$DoctorErrorCopyWithImpl(this._self, this._then);

  final DoctorError _self;
  final $Res Function(DoctorError) _then;

/// Create a copy of DoctorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(DoctorError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$DoctorDetailState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DoctorDetailState()';
}


}

/// @nodoc
class $DoctorDetailStateCopyWith<$Res>  {
$DoctorDetailStateCopyWith(DoctorDetailState _, $Res Function(DoctorDetailState) __);
}


/// @nodoc


class DoctorDetailInitial implements DoctorDetailState {
  const DoctorDetailInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorDetailInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DoctorDetailState.initial()';
}


}




/// @nodoc


class DoctorDetailLoading implements DoctorDetailState {
  const DoctorDetailLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorDetailLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DoctorDetailState.loading()';
}


}




/// @nodoc


class DoctorDetailLoaded implements DoctorDetailState {
  const DoctorDetailLoaded({required this.doctor, required final  List<MrVisitLog> visitHistory, final  List<DoctorClinic> clinics = const []}): _visitHistory = visitHistory,_clinics = clinics;
  

 final  Doctor doctor;
 final  List<MrVisitLog> _visitHistory;
 List<MrVisitLog> get visitHistory {
  if (_visitHistory is EqualUnmodifiableListView) return _visitHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_visitHistory);
}

 final  List<DoctorClinic> _clinics;
@JsonKey() List<DoctorClinic> get clinics {
  if (_clinics is EqualUnmodifiableListView) return _clinics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_clinics);
}


/// Create a copy of DoctorDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoctorDetailLoadedCopyWith<DoctorDetailLoaded> get copyWith => _$DoctorDetailLoadedCopyWithImpl<DoctorDetailLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorDetailLoaded&&(identical(other.doctor, doctor) || other.doctor == doctor)&&const DeepCollectionEquality().equals(other._visitHistory, _visitHistory)&&const DeepCollectionEquality().equals(other._clinics, _clinics));
}


@override
int get hashCode => Object.hash(runtimeType,doctor,const DeepCollectionEquality().hash(_visitHistory),const DeepCollectionEquality().hash(_clinics));

@override
String toString() {
  return 'DoctorDetailState.loaded(doctor: $doctor, visitHistory: $visitHistory, clinics: $clinics)';
}


}

/// @nodoc
abstract mixin class $DoctorDetailLoadedCopyWith<$Res> implements $DoctorDetailStateCopyWith<$Res> {
  factory $DoctorDetailLoadedCopyWith(DoctorDetailLoaded value, $Res Function(DoctorDetailLoaded) _then) = _$DoctorDetailLoadedCopyWithImpl;
@useResult
$Res call({
 Doctor doctor, List<MrVisitLog> visitHistory, List<DoctorClinic> clinics
});


$DoctorCopyWith<$Res> get doctor;

}
/// @nodoc
class _$DoctorDetailLoadedCopyWithImpl<$Res>
    implements $DoctorDetailLoadedCopyWith<$Res> {
  _$DoctorDetailLoadedCopyWithImpl(this._self, this._then);

  final DoctorDetailLoaded _self;
  final $Res Function(DoctorDetailLoaded) _then;

/// Create a copy of DoctorDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? doctor = null,Object? visitHistory = null,Object? clinics = null,}) {
  return _then(DoctorDetailLoaded(
doctor: null == doctor ? _self.doctor : doctor // ignore: cast_nullable_to_non_nullable
as Doctor,visitHistory: null == visitHistory ? _self._visitHistory : visitHistory // ignore: cast_nullable_to_non_nullable
as List<MrVisitLog>,clinics: null == clinics ? _self._clinics : clinics // ignore: cast_nullable_to_non_nullable
as List<DoctorClinic>,
  ));
}

/// Create a copy of DoctorDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DoctorCopyWith<$Res> get doctor {
  
  return $DoctorCopyWith<$Res>(_self.doctor, (value) {
    return _then(_self.copyWith(doctor: value));
  });
}
}

/// @nodoc


class DoctorDetailError implements DoctorDetailState {
  const DoctorDetailError({required this.message});
  

 final  String message;

/// Create a copy of DoctorDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoctorDetailErrorCopyWith<DoctorDetailError> get copyWith => _$DoctorDetailErrorCopyWithImpl<DoctorDetailError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorDetailError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'DoctorDetailState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $DoctorDetailErrorCopyWith<$Res> implements $DoctorDetailStateCopyWith<$Res> {
  factory $DoctorDetailErrorCopyWith(DoctorDetailError value, $Res Function(DoctorDetailError) _then) = _$DoctorDetailErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$DoctorDetailErrorCopyWithImpl<$Res>
    implements $DoctorDetailErrorCopyWith<$Res> {
  _$DoctorDetailErrorCopyWithImpl(this._self, this._then);

  final DoctorDetailError _self;
  final $Res Function(DoctorDetailError) _then;

/// Create a copy of DoctorDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(DoctorDetailError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$VisitLogState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VisitLogState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VisitLogState()';
}


}

/// @nodoc
class $VisitLogStateCopyWith<$Res>  {
$VisitLogStateCopyWith(VisitLogState _, $Res Function(VisitLogState) __);
}


/// @nodoc


class VisitLogInitial implements VisitLogState {
  const VisitLogInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VisitLogInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VisitLogState.initial()';
}


}




/// @nodoc


class VisitLogLoading implements VisitLogState {
  const VisitLogLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VisitLogLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VisitLogState.loading()';
}


}




/// @nodoc


class VisitLogSuccess implements VisitLogState {
  const VisitLogSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VisitLogSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VisitLogState.success()';
}


}




/// @nodoc


class VisitLogError implements VisitLogState {
  const VisitLogError({required this.message});
  

 final  String message;

/// Create a copy of VisitLogState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VisitLogErrorCopyWith<VisitLogError> get copyWith => _$VisitLogErrorCopyWithImpl<VisitLogError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VisitLogError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'VisitLogState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $VisitLogErrorCopyWith<$Res> implements $VisitLogStateCopyWith<$Res> {
  factory $VisitLogErrorCopyWith(VisitLogError value, $Res Function(VisitLogError) _then) = _$VisitLogErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$VisitLogErrorCopyWithImpl<$Res>
    implements $VisitLogErrorCopyWith<$Res> {
  _$VisitLogErrorCopyWithImpl(this._self, this._then);

  final VisitLogError _self;
  final $Res Function(VisitLogError) _then;

/// Create a copy of VisitLogState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(VisitLogError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doctor_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Doctor {

 String get id;@JsonKey(name: 'full_name') String get fullName; String? get specialty;@JsonKey(name: 'clinic_address') String? get clinicAddress;@JsonKey(name: 'phone_number') String? get phoneNumber; String? get email;@JsonKey(name: 'date_of_birth') DateTime? get dateOfBirth;@JsonKey(name: 'anniversary_date') DateTime? get anniversaryDate; DoctorTier? get tier; double? get latitude; double? get longitude;@JsonKey(name: 'is_active') bool get isActive;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;@JsonKey(name: 'created_by') String? get createdBy;
/// Create a copy of Doctor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoctorCopyWith<Doctor> get copyWith => _$DoctorCopyWithImpl<Doctor>(this as Doctor, _$identity);

  /// Serializes this Doctor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Doctor&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.specialty, specialty) || other.specialty == specialty)&&(identical(other.clinicAddress, clinicAddress) || other.clinicAddress == clinicAddress)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.anniversaryDate, anniversaryDate) || other.anniversaryDate == anniversaryDate)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,specialty,clinicAddress,phoneNumber,email,dateOfBirth,anniversaryDate,tier,latitude,longitude,isActive,createdAt,updatedAt,createdBy);

@override
String toString() {
  return 'Doctor(id: $id, fullName: $fullName, specialty: $specialty, clinicAddress: $clinicAddress, phoneNumber: $phoneNumber, email: $email, dateOfBirth: $dateOfBirth, anniversaryDate: $anniversaryDate, tier: $tier, latitude: $latitude, longitude: $longitude, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy)';
}


}

/// @nodoc
abstract mixin class $DoctorCopyWith<$Res>  {
  factory $DoctorCopyWith(Doctor value, $Res Function(Doctor) _then) = _$DoctorCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'full_name') String fullName, String? specialty,@JsonKey(name: 'clinic_address') String? clinicAddress,@JsonKey(name: 'phone_number') String? phoneNumber, String? email,@JsonKey(name: 'date_of_birth') DateTime? dateOfBirth,@JsonKey(name: 'anniversary_date') DateTime? anniversaryDate, DoctorTier? tier, double? latitude, double? longitude,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt,@JsonKey(name: 'created_by') String? createdBy
});




}
/// @nodoc
class _$DoctorCopyWithImpl<$Res>
    implements $DoctorCopyWith<$Res> {
  _$DoctorCopyWithImpl(this._self, this._then);

  final Doctor _self;
  final $Res Function(Doctor) _then;

/// Create a copy of Doctor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? specialty = freezed,Object? clinicAddress = freezed,Object? phoneNumber = freezed,Object? email = freezed,Object? dateOfBirth = freezed,Object? anniversaryDate = freezed,Object? tier = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,Object? createdBy = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,specialty: freezed == specialty ? _self.specialty : specialty // ignore: cast_nullable_to_non_nullable
as String?,clinicAddress: freezed == clinicAddress ? _self.clinicAddress : clinicAddress // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,anniversaryDate: freezed == anniversaryDate ? _self.anniversaryDate : anniversaryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,tier: freezed == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as DoctorTier?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Doctor implements Doctor {
  const _Doctor({required this.id, @JsonKey(name: 'full_name') required this.fullName, this.specialty, @JsonKey(name: 'clinic_address') this.clinicAddress, @JsonKey(name: 'phone_number') this.phoneNumber, this.email, @JsonKey(name: 'date_of_birth') this.dateOfBirth, @JsonKey(name: 'anniversary_date') this.anniversaryDate, this.tier, this.latitude, this.longitude, @JsonKey(name: 'is_active') this.isActive = true, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt, @JsonKey(name: 'created_by') this.createdBy});
  factory _Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

@override final  String id;
@override@JsonKey(name: 'full_name') final  String fullName;
@override final  String? specialty;
@override@JsonKey(name: 'clinic_address') final  String? clinicAddress;
@override@JsonKey(name: 'phone_number') final  String? phoneNumber;
@override final  String? email;
@override@JsonKey(name: 'date_of_birth') final  DateTime? dateOfBirth;
@override@JsonKey(name: 'anniversary_date') final  DateTime? anniversaryDate;
@override final  DoctorTier? tier;
@override final  double? latitude;
@override final  double? longitude;
@override@JsonKey(name: 'is_active') final  bool isActive;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;
@override@JsonKey(name: 'created_by') final  String? createdBy;

/// Create a copy of Doctor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DoctorCopyWith<_Doctor> get copyWith => __$DoctorCopyWithImpl<_Doctor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DoctorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Doctor&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.specialty, specialty) || other.specialty == specialty)&&(identical(other.clinicAddress, clinicAddress) || other.clinicAddress == clinicAddress)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.anniversaryDate, anniversaryDate) || other.anniversaryDate == anniversaryDate)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,specialty,clinicAddress,phoneNumber,email,dateOfBirth,anniversaryDate,tier,latitude,longitude,isActive,createdAt,updatedAt,createdBy);

@override
String toString() {
  return 'Doctor(id: $id, fullName: $fullName, specialty: $specialty, clinicAddress: $clinicAddress, phoneNumber: $phoneNumber, email: $email, dateOfBirth: $dateOfBirth, anniversaryDate: $anniversaryDate, tier: $tier, latitude: $latitude, longitude: $longitude, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy)';
}


}

/// @nodoc
abstract mixin class _$DoctorCopyWith<$Res> implements $DoctorCopyWith<$Res> {
  factory _$DoctorCopyWith(_Doctor value, $Res Function(_Doctor) _then) = __$DoctorCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'full_name') String fullName, String? specialty,@JsonKey(name: 'clinic_address') String? clinicAddress,@JsonKey(name: 'phone_number') String? phoneNumber, String? email,@JsonKey(name: 'date_of_birth') DateTime? dateOfBirth,@JsonKey(name: 'anniversary_date') DateTime? anniversaryDate, DoctorTier? tier, double? latitude, double? longitude,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt,@JsonKey(name: 'created_by') String? createdBy
});




}
/// @nodoc
class __$DoctorCopyWithImpl<$Res>
    implements _$DoctorCopyWith<$Res> {
  __$DoctorCopyWithImpl(this._self, this._then);

  final _Doctor _self;
  final $Res Function(_Doctor) _then;

/// Create a copy of Doctor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? specialty = freezed,Object? clinicAddress = freezed,Object? phoneNumber = freezed,Object? email = freezed,Object? dateOfBirth = freezed,Object? anniversaryDate = freezed,Object? tier = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,Object? createdBy = freezed,}) {
  return _then(_Doctor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,specialty: freezed == specialty ? _self.specialty : specialty // ignore: cast_nullable_to_non_nullable
as String?,clinicAddress: freezed == clinicAddress ? _self.clinicAddress : clinicAddress // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,anniversaryDate: freezed == anniversaryDate ? _self.anniversaryDate : anniversaryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,tier: freezed == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as DoctorTier?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MrVisitLog {

 String get id;@JsonKey(name: 'mr_user_id') String get mrUserId;@JsonKey(name: 'doctor_id') String get doctorId;@JsonKey(name: 'visit_date') DateTime get visitDate;@JsonKey(name: 'products_detailed') String? get productsDetailed;@JsonKey(name: 'feedback_received') String? get feedbackReceived;@JsonKey(name: 'samples_provided') String? get samplesProvided;@JsonKey(name: 'competitor_activity_notes') String? get competitorActivityNotes;@JsonKey(name: 'prescription_potential_notes') String? get prescriptionPotentialNotes;@JsonKey(name: 'next_visit_date') DateTime? get nextVisitDate;@JsonKey(name: 'next_visit_objective') String? get nextVisitObjective;@JsonKey(name: 'linked_sale_order_id') String? get linkedSaleOrderId;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of MrVisitLog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MrVisitLogCopyWith<MrVisitLog> get copyWith => _$MrVisitLogCopyWithImpl<MrVisitLog>(this as MrVisitLog, _$identity);

  /// Serializes this MrVisitLog to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MrVisitLog&&(identical(other.id, id) || other.id == id)&&(identical(other.mrUserId, mrUserId) || other.mrUserId == mrUserId)&&(identical(other.doctorId, doctorId) || other.doctorId == doctorId)&&(identical(other.visitDate, visitDate) || other.visitDate == visitDate)&&(identical(other.productsDetailed, productsDetailed) || other.productsDetailed == productsDetailed)&&(identical(other.feedbackReceived, feedbackReceived) || other.feedbackReceived == feedbackReceived)&&(identical(other.samplesProvided, samplesProvided) || other.samplesProvided == samplesProvided)&&(identical(other.competitorActivityNotes, competitorActivityNotes) || other.competitorActivityNotes == competitorActivityNotes)&&(identical(other.prescriptionPotentialNotes, prescriptionPotentialNotes) || other.prescriptionPotentialNotes == prescriptionPotentialNotes)&&(identical(other.nextVisitDate, nextVisitDate) || other.nextVisitDate == nextVisitDate)&&(identical(other.nextVisitObjective, nextVisitObjective) || other.nextVisitObjective == nextVisitObjective)&&(identical(other.linkedSaleOrderId, linkedSaleOrderId) || other.linkedSaleOrderId == linkedSaleOrderId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mrUserId,doctorId,visitDate,productsDetailed,feedbackReceived,samplesProvided,competitorActivityNotes,prescriptionPotentialNotes,nextVisitDate,nextVisitObjective,linkedSaleOrderId,createdAt);

@override
String toString() {
  return 'MrVisitLog(id: $id, mrUserId: $mrUserId, doctorId: $doctorId, visitDate: $visitDate, productsDetailed: $productsDetailed, feedbackReceived: $feedbackReceived, samplesProvided: $samplesProvided, competitorActivityNotes: $competitorActivityNotes, prescriptionPotentialNotes: $prescriptionPotentialNotes, nextVisitDate: $nextVisitDate, nextVisitObjective: $nextVisitObjective, linkedSaleOrderId: $linkedSaleOrderId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $MrVisitLogCopyWith<$Res>  {
  factory $MrVisitLogCopyWith(MrVisitLog value, $Res Function(MrVisitLog) _then) = _$MrVisitLogCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'mr_user_id') String mrUserId,@JsonKey(name: 'doctor_id') String doctorId,@JsonKey(name: 'visit_date') DateTime visitDate,@JsonKey(name: 'products_detailed') String? productsDetailed,@JsonKey(name: 'feedback_received') String? feedbackReceived,@JsonKey(name: 'samples_provided') String? samplesProvided,@JsonKey(name: 'competitor_activity_notes') String? competitorActivityNotes,@JsonKey(name: 'prescription_potential_notes') String? prescriptionPotentialNotes,@JsonKey(name: 'next_visit_date') DateTime? nextVisitDate,@JsonKey(name: 'next_visit_objective') String? nextVisitObjective,@JsonKey(name: 'linked_sale_order_id') String? linkedSaleOrderId,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$MrVisitLogCopyWithImpl<$Res>
    implements $MrVisitLogCopyWith<$Res> {
  _$MrVisitLogCopyWithImpl(this._self, this._then);

  final MrVisitLog _self;
  final $Res Function(MrVisitLog) _then;

/// Create a copy of MrVisitLog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? mrUserId = null,Object? doctorId = null,Object? visitDate = null,Object? productsDetailed = freezed,Object? feedbackReceived = freezed,Object? samplesProvided = freezed,Object? competitorActivityNotes = freezed,Object? prescriptionPotentialNotes = freezed,Object? nextVisitDate = freezed,Object? nextVisitObjective = freezed,Object? linkedSaleOrderId = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mrUserId: null == mrUserId ? _self.mrUserId : mrUserId // ignore: cast_nullable_to_non_nullable
as String,doctorId: null == doctorId ? _self.doctorId : doctorId // ignore: cast_nullable_to_non_nullable
as String,visitDate: null == visitDate ? _self.visitDate : visitDate // ignore: cast_nullable_to_non_nullable
as DateTime,productsDetailed: freezed == productsDetailed ? _self.productsDetailed : productsDetailed // ignore: cast_nullable_to_non_nullable
as String?,feedbackReceived: freezed == feedbackReceived ? _self.feedbackReceived : feedbackReceived // ignore: cast_nullable_to_non_nullable
as String?,samplesProvided: freezed == samplesProvided ? _self.samplesProvided : samplesProvided // ignore: cast_nullable_to_non_nullable
as String?,competitorActivityNotes: freezed == competitorActivityNotes ? _self.competitorActivityNotes : competitorActivityNotes // ignore: cast_nullable_to_non_nullable
as String?,prescriptionPotentialNotes: freezed == prescriptionPotentialNotes ? _self.prescriptionPotentialNotes : prescriptionPotentialNotes // ignore: cast_nullable_to_non_nullable
as String?,nextVisitDate: freezed == nextVisitDate ? _self.nextVisitDate : nextVisitDate // ignore: cast_nullable_to_non_nullable
as DateTime?,nextVisitObjective: freezed == nextVisitObjective ? _self.nextVisitObjective : nextVisitObjective // ignore: cast_nullable_to_non_nullable
as String?,linkedSaleOrderId: freezed == linkedSaleOrderId ? _self.linkedSaleOrderId : linkedSaleOrderId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MrVisitLog implements MrVisitLog {
  const _MrVisitLog({required this.id, @JsonKey(name: 'mr_user_id') required this.mrUserId, @JsonKey(name: 'doctor_id') required this.doctorId, @JsonKey(name: 'visit_date') required this.visitDate, @JsonKey(name: 'products_detailed') this.productsDetailed, @JsonKey(name: 'feedback_received') this.feedbackReceived, @JsonKey(name: 'samples_provided') this.samplesProvided, @JsonKey(name: 'competitor_activity_notes') this.competitorActivityNotes, @JsonKey(name: 'prescription_potential_notes') this.prescriptionPotentialNotes, @JsonKey(name: 'next_visit_date') this.nextVisitDate, @JsonKey(name: 'next_visit_objective') this.nextVisitObjective, @JsonKey(name: 'linked_sale_order_id') this.linkedSaleOrderId, @JsonKey(name: 'created_at') required this.createdAt});
  factory _MrVisitLog.fromJson(Map<String, dynamic> json) => _$MrVisitLogFromJson(json);

@override final  String id;
@override@JsonKey(name: 'mr_user_id') final  String mrUserId;
@override@JsonKey(name: 'doctor_id') final  String doctorId;
@override@JsonKey(name: 'visit_date') final  DateTime visitDate;
@override@JsonKey(name: 'products_detailed') final  String? productsDetailed;
@override@JsonKey(name: 'feedback_received') final  String? feedbackReceived;
@override@JsonKey(name: 'samples_provided') final  String? samplesProvided;
@override@JsonKey(name: 'competitor_activity_notes') final  String? competitorActivityNotes;
@override@JsonKey(name: 'prescription_potential_notes') final  String? prescriptionPotentialNotes;
@override@JsonKey(name: 'next_visit_date') final  DateTime? nextVisitDate;
@override@JsonKey(name: 'next_visit_objective') final  String? nextVisitObjective;
@override@JsonKey(name: 'linked_sale_order_id') final  String? linkedSaleOrderId;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of MrVisitLog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MrVisitLogCopyWith<_MrVisitLog> get copyWith => __$MrVisitLogCopyWithImpl<_MrVisitLog>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MrVisitLogToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MrVisitLog&&(identical(other.id, id) || other.id == id)&&(identical(other.mrUserId, mrUserId) || other.mrUserId == mrUserId)&&(identical(other.doctorId, doctorId) || other.doctorId == doctorId)&&(identical(other.visitDate, visitDate) || other.visitDate == visitDate)&&(identical(other.productsDetailed, productsDetailed) || other.productsDetailed == productsDetailed)&&(identical(other.feedbackReceived, feedbackReceived) || other.feedbackReceived == feedbackReceived)&&(identical(other.samplesProvided, samplesProvided) || other.samplesProvided == samplesProvided)&&(identical(other.competitorActivityNotes, competitorActivityNotes) || other.competitorActivityNotes == competitorActivityNotes)&&(identical(other.prescriptionPotentialNotes, prescriptionPotentialNotes) || other.prescriptionPotentialNotes == prescriptionPotentialNotes)&&(identical(other.nextVisitDate, nextVisitDate) || other.nextVisitDate == nextVisitDate)&&(identical(other.nextVisitObjective, nextVisitObjective) || other.nextVisitObjective == nextVisitObjective)&&(identical(other.linkedSaleOrderId, linkedSaleOrderId) || other.linkedSaleOrderId == linkedSaleOrderId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mrUserId,doctorId,visitDate,productsDetailed,feedbackReceived,samplesProvided,competitorActivityNotes,prescriptionPotentialNotes,nextVisitDate,nextVisitObjective,linkedSaleOrderId,createdAt);

@override
String toString() {
  return 'MrVisitLog(id: $id, mrUserId: $mrUserId, doctorId: $doctorId, visitDate: $visitDate, productsDetailed: $productsDetailed, feedbackReceived: $feedbackReceived, samplesProvided: $samplesProvided, competitorActivityNotes: $competitorActivityNotes, prescriptionPotentialNotes: $prescriptionPotentialNotes, nextVisitDate: $nextVisitDate, nextVisitObjective: $nextVisitObjective, linkedSaleOrderId: $linkedSaleOrderId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MrVisitLogCopyWith<$Res> implements $MrVisitLogCopyWith<$Res> {
  factory _$MrVisitLogCopyWith(_MrVisitLog value, $Res Function(_MrVisitLog) _then) = __$MrVisitLogCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'mr_user_id') String mrUserId,@JsonKey(name: 'doctor_id') String doctorId,@JsonKey(name: 'visit_date') DateTime visitDate,@JsonKey(name: 'products_detailed') String? productsDetailed,@JsonKey(name: 'feedback_received') String? feedbackReceived,@JsonKey(name: 'samples_provided') String? samplesProvided,@JsonKey(name: 'competitor_activity_notes') String? competitorActivityNotes,@JsonKey(name: 'prescription_potential_notes') String? prescriptionPotentialNotes,@JsonKey(name: 'next_visit_date') DateTime? nextVisitDate,@JsonKey(name: 'next_visit_objective') String? nextVisitObjective,@JsonKey(name: 'linked_sale_order_id') String? linkedSaleOrderId,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$MrVisitLogCopyWithImpl<$Res>
    implements _$MrVisitLogCopyWith<$Res> {
  __$MrVisitLogCopyWithImpl(this._self, this._then);

  final _MrVisitLog _self;
  final $Res Function(_MrVisitLog) _then;

/// Create a copy of MrVisitLog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mrUserId = null,Object? doctorId = null,Object? visitDate = null,Object? productsDetailed = freezed,Object? feedbackReceived = freezed,Object? samplesProvided = freezed,Object? competitorActivityNotes = freezed,Object? prescriptionPotentialNotes = freezed,Object? nextVisitDate = freezed,Object? nextVisitObjective = freezed,Object? linkedSaleOrderId = freezed,Object? createdAt = null,}) {
  return _then(_MrVisitLog(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mrUserId: null == mrUserId ? _self.mrUserId : mrUserId // ignore: cast_nullable_to_non_nullable
as String,doctorId: null == doctorId ? _self.doctorId : doctorId // ignore: cast_nullable_to_non_nullable
as String,visitDate: null == visitDate ? _self.visitDate : visitDate // ignore: cast_nullable_to_non_nullable
as DateTime,productsDetailed: freezed == productsDetailed ? _self.productsDetailed : productsDetailed // ignore: cast_nullable_to_non_nullable
as String?,feedbackReceived: freezed == feedbackReceived ? _self.feedbackReceived : feedbackReceived // ignore: cast_nullable_to_non_nullable
as String?,samplesProvided: freezed == samplesProvided ? _self.samplesProvided : samplesProvided // ignore: cast_nullable_to_non_nullable
as String?,competitorActivityNotes: freezed == competitorActivityNotes ? _self.competitorActivityNotes : competitorActivityNotes // ignore: cast_nullable_to_non_nullable
as String?,prescriptionPotentialNotes: freezed == prescriptionPotentialNotes ? _self.prescriptionPotentialNotes : prescriptionPotentialNotes // ignore: cast_nullable_to_non_nullable
as String?,nextVisitDate: freezed == nextVisitDate ? _self.nextVisitDate : nextVisitDate // ignore: cast_nullable_to_non_nullable
as DateTime?,nextVisitObjective: freezed == nextVisitObjective ? _self.nextVisitObjective : nextVisitObjective // ignore: cast_nullable_to_non_nullable
as String?,linkedSaleOrderId: freezed == linkedSaleOrderId ? _self.linkedSaleOrderId : linkedSaleOrderId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$CreateVisitLogRequest {

@JsonKey(name: 'doctor_id') String get doctorId;@JsonKey(name: 'visit_date') DateTime get visitDate;@JsonKey(name: 'products_detailed') String? get productsDetailed;@JsonKey(name: 'feedback_received') String? get feedbackReceived;@JsonKey(name: 'next_visit_date') DateTime? get nextVisitDate;@JsonKey(name: 'next_visit_objective') String? get nextVisitObjective;
/// Create a copy of CreateVisitLogRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateVisitLogRequestCopyWith<CreateVisitLogRequest> get copyWith => _$CreateVisitLogRequestCopyWithImpl<CreateVisitLogRequest>(this as CreateVisitLogRequest, _$identity);

  /// Serializes this CreateVisitLogRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateVisitLogRequest&&(identical(other.doctorId, doctorId) || other.doctorId == doctorId)&&(identical(other.visitDate, visitDate) || other.visitDate == visitDate)&&(identical(other.productsDetailed, productsDetailed) || other.productsDetailed == productsDetailed)&&(identical(other.feedbackReceived, feedbackReceived) || other.feedbackReceived == feedbackReceived)&&(identical(other.nextVisitDate, nextVisitDate) || other.nextVisitDate == nextVisitDate)&&(identical(other.nextVisitObjective, nextVisitObjective) || other.nextVisitObjective == nextVisitObjective));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,doctorId,visitDate,productsDetailed,feedbackReceived,nextVisitDate,nextVisitObjective);

@override
String toString() {
  return 'CreateVisitLogRequest(doctorId: $doctorId, visitDate: $visitDate, productsDetailed: $productsDetailed, feedbackReceived: $feedbackReceived, nextVisitDate: $nextVisitDate, nextVisitObjective: $nextVisitObjective)';
}


}

/// @nodoc
abstract mixin class $CreateVisitLogRequestCopyWith<$Res>  {
  factory $CreateVisitLogRequestCopyWith(CreateVisitLogRequest value, $Res Function(CreateVisitLogRequest) _then) = _$CreateVisitLogRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'doctor_id') String doctorId,@JsonKey(name: 'visit_date') DateTime visitDate,@JsonKey(name: 'products_detailed') String? productsDetailed,@JsonKey(name: 'feedback_received') String? feedbackReceived,@JsonKey(name: 'next_visit_date') DateTime? nextVisitDate,@JsonKey(name: 'next_visit_objective') String? nextVisitObjective
});




}
/// @nodoc
class _$CreateVisitLogRequestCopyWithImpl<$Res>
    implements $CreateVisitLogRequestCopyWith<$Res> {
  _$CreateVisitLogRequestCopyWithImpl(this._self, this._then);

  final CreateVisitLogRequest _self;
  final $Res Function(CreateVisitLogRequest) _then;

/// Create a copy of CreateVisitLogRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? doctorId = null,Object? visitDate = null,Object? productsDetailed = freezed,Object? feedbackReceived = freezed,Object? nextVisitDate = freezed,Object? nextVisitObjective = freezed,}) {
  return _then(_self.copyWith(
doctorId: null == doctorId ? _self.doctorId : doctorId // ignore: cast_nullable_to_non_nullable
as String,visitDate: null == visitDate ? _self.visitDate : visitDate // ignore: cast_nullable_to_non_nullable
as DateTime,productsDetailed: freezed == productsDetailed ? _self.productsDetailed : productsDetailed // ignore: cast_nullable_to_non_nullable
as String?,feedbackReceived: freezed == feedbackReceived ? _self.feedbackReceived : feedbackReceived // ignore: cast_nullable_to_non_nullable
as String?,nextVisitDate: freezed == nextVisitDate ? _self.nextVisitDate : nextVisitDate // ignore: cast_nullable_to_non_nullable
as DateTime?,nextVisitObjective: freezed == nextVisitObjective ? _self.nextVisitObjective : nextVisitObjective // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CreateVisitLogRequest implements CreateVisitLogRequest {
  const _CreateVisitLogRequest({@JsonKey(name: 'doctor_id') required this.doctorId, @JsonKey(name: 'visit_date') required this.visitDate, @JsonKey(name: 'products_detailed') this.productsDetailed, @JsonKey(name: 'feedback_received') this.feedbackReceived, @JsonKey(name: 'next_visit_date') this.nextVisitDate, @JsonKey(name: 'next_visit_objective') this.nextVisitObjective});
  factory _CreateVisitLogRequest.fromJson(Map<String, dynamic> json) => _$CreateVisitLogRequestFromJson(json);

@override@JsonKey(name: 'doctor_id') final  String doctorId;
@override@JsonKey(name: 'visit_date') final  DateTime visitDate;
@override@JsonKey(name: 'products_detailed') final  String? productsDetailed;
@override@JsonKey(name: 'feedback_received') final  String? feedbackReceived;
@override@JsonKey(name: 'next_visit_date') final  DateTime? nextVisitDate;
@override@JsonKey(name: 'next_visit_objective') final  String? nextVisitObjective;

/// Create a copy of CreateVisitLogRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateVisitLogRequestCopyWith<_CreateVisitLogRequest> get copyWith => __$CreateVisitLogRequestCopyWithImpl<_CreateVisitLogRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateVisitLogRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateVisitLogRequest&&(identical(other.doctorId, doctorId) || other.doctorId == doctorId)&&(identical(other.visitDate, visitDate) || other.visitDate == visitDate)&&(identical(other.productsDetailed, productsDetailed) || other.productsDetailed == productsDetailed)&&(identical(other.feedbackReceived, feedbackReceived) || other.feedbackReceived == feedbackReceived)&&(identical(other.nextVisitDate, nextVisitDate) || other.nextVisitDate == nextVisitDate)&&(identical(other.nextVisitObjective, nextVisitObjective) || other.nextVisitObjective == nextVisitObjective));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,doctorId,visitDate,productsDetailed,feedbackReceived,nextVisitDate,nextVisitObjective);

@override
String toString() {
  return 'CreateVisitLogRequest(doctorId: $doctorId, visitDate: $visitDate, productsDetailed: $productsDetailed, feedbackReceived: $feedbackReceived, nextVisitDate: $nextVisitDate, nextVisitObjective: $nextVisitObjective)';
}


}

/// @nodoc
abstract mixin class _$CreateVisitLogRequestCopyWith<$Res> implements $CreateVisitLogRequestCopyWith<$Res> {
  factory _$CreateVisitLogRequestCopyWith(_CreateVisitLogRequest value, $Res Function(_CreateVisitLogRequest) _then) = __$CreateVisitLogRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'doctor_id') String doctorId,@JsonKey(name: 'visit_date') DateTime visitDate,@JsonKey(name: 'products_detailed') String? productsDetailed,@JsonKey(name: 'feedback_received') String? feedbackReceived,@JsonKey(name: 'next_visit_date') DateTime? nextVisitDate,@JsonKey(name: 'next_visit_objective') String? nextVisitObjective
});




}
/// @nodoc
class __$CreateVisitLogRequestCopyWithImpl<$Res>
    implements _$CreateVisitLogRequestCopyWith<$Res> {
  __$CreateVisitLogRequestCopyWithImpl(this._self, this._then);

  final _CreateVisitLogRequest _self;
  final $Res Function(_CreateVisitLogRequest) _then;

/// Create a copy of CreateVisitLogRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? doctorId = null,Object? visitDate = null,Object? productsDetailed = freezed,Object? feedbackReceived = freezed,Object? nextVisitDate = freezed,Object? nextVisitObjective = freezed,}) {
  return _then(_CreateVisitLogRequest(
doctorId: null == doctorId ? _self.doctorId : doctorId // ignore: cast_nullable_to_non_nullable
as String,visitDate: null == visitDate ? _self.visitDate : visitDate // ignore: cast_nullable_to_non_nullable
as DateTime,productsDetailed: freezed == productsDetailed ? _self.productsDetailed : productsDetailed // ignore: cast_nullable_to_non_nullable
as String?,feedbackReceived: freezed == feedbackReceived ? _self.feedbackReceived : feedbackReceived // ignore: cast_nullable_to_non_nullable
as String?,nextVisitDate: freezed == nextVisitDate ? _self.nextVisitDate : nextVisitDate // ignore: cast_nullable_to_non_nullable
as DateTime?,nextVisitObjective: freezed == nextVisitObjective ? _self.nextVisitObjective : nextVisitObjective // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

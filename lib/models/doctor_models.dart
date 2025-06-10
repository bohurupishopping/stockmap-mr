import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor_models.freezed.dart';
part 'doctor_models.g.dart';

enum DoctorTier {
  @JsonValue('A')
  a,
  @JsonValue('B')
  b,
  @JsonValue('C')
  c,
}

@freezed
class Doctor with _$Doctor {
  const factory Doctor({
    required String id,
    @JsonKey(name: 'full_name') required String fullName,
    String? specialty,
    @JsonKey(name: 'clinic_address') String? clinicAddress,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    String? email,
    @JsonKey(name: 'date_of_birth') DateTime? dateOfBirth,
    @JsonKey(name: 'anniversary_date') DateTime? anniversaryDate,
    DoctorTier? tier,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'created_by') String? createdBy,
  }) = _Doctor;

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

@freezed
class MrVisitLog with _$MrVisitLog {
  const factory MrVisitLog({
    required String id,
    @JsonKey(name: 'mr_user_id') required String mrUserId,
    @JsonKey(name: 'doctor_id') required String doctorId,
    @JsonKey(name: 'visit_date') required DateTime visitDate,
    @JsonKey(name: 'products_detailed') String? productsDetailed,
    @JsonKey(name: 'feedback_received') String? feedbackReceived,
    @JsonKey(name: 'samples_provided') String? samplesProvided,
    @JsonKey(name: 'competitor_activity_notes') String? competitorActivityNotes,
    @JsonKey(name: 'prescription_potential_notes') String? prescriptionPotentialNotes,
    @JsonKey(name: 'next_visit_date') DateTime? nextVisitDate,
    @JsonKey(name: 'next_visit_objective') String? nextVisitObjective,
    @JsonKey(name: 'linked_sale_order_id') String? linkedSaleOrderId,
    @JsonKey(name: 'is_location_verified') bool? isLocationVerified,
    @JsonKey(name: 'distance_from_clinic_meters') double? distanceFromClinicMeters,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _MrVisitLog;

  factory MrVisitLog.fromJson(Map<String, dynamic> json) => _$MrVisitLogFromJson(json);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

@freezed
class CreateVisitLogRequest with _$CreateVisitLogRequest {
  const factory CreateVisitLogRequest({
    @JsonKey(name: 'doctor_id') required String doctorId,
    @JsonKey(name: 'visit_date') required DateTime visitDate,
    @JsonKey(name: 'products_detailed') String? productsDetailed,
    @JsonKey(name: 'feedback_received') String? feedbackReceived,
    @JsonKey(name: 'next_visit_date') DateTime? nextVisitDate,
    @JsonKey(name: 'next_visit_objective') String? nextVisitObjective,
    @JsonKey(name: 'is_location_verified') bool? isLocationVerified,
    @JsonKey(name: 'distance_from_clinic_meters') double? distanceFromClinicMeters,
  }) = _CreateVisitLogRequest;

  factory CreateVisitLogRequest.fromJson(Map<String, dynamic> json) => _$CreateVisitLogRequestFromJson(json);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
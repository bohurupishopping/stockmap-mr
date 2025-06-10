// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Doctor _$DoctorFromJson(Map<String, dynamic> json) => _Doctor(
  id: json['id'] as String,
  fullName: json['full_name'] as String,
  specialty: json['specialty'] as String?,
  clinicAddress: json['clinic_address'] as String?,
  phoneNumber: json['phone_number'] as String?,
  email: json['email'] as String?,
  dateOfBirth: json['date_of_birth'] == null
      ? null
      : DateTime.parse(json['date_of_birth'] as String),
  anniversaryDate: json['anniversary_date'] == null
      ? null
      : DateTime.parse(json['anniversary_date'] as String),
  tier: $enumDecodeNullable(_$DoctorTierEnumMap, json['tier']),
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  isActive: json['is_active'] as bool? ?? true,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  createdBy: json['created_by'] as String?,
);

Map<String, dynamic> _$DoctorToJson(_Doctor instance) => <String, dynamic>{
  'id': instance.id,
  'full_name': instance.fullName,
  'specialty': instance.specialty,
  'clinic_address': instance.clinicAddress,
  'phone_number': instance.phoneNumber,
  'email': instance.email,
  'date_of_birth': instance.dateOfBirth?.toIso8601String(),
  'anniversary_date': instance.anniversaryDate?.toIso8601String(),
  'tier': _$DoctorTierEnumMap[instance.tier],
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'is_active': instance.isActive,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'created_by': instance.createdBy,
};

const _$DoctorTierEnumMap = {
  DoctorTier.a: 'A',
  DoctorTier.b: 'B',
  DoctorTier.c: 'C',
};

_MrVisitLog _$MrVisitLogFromJson(Map<String, dynamic> json) => _MrVisitLog(
  id: json['id'] as String,
  mrUserId: json['mr_user_id'] as String,
  doctorId: json['doctor_id'] as String,
  visitDate: DateTime.parse(json['visit_date'] as String),
  productsDetailed: json['products_detailed'] as String?,
  feedbackReceived: json['feedback_received'] as String?,
  samplesProvided: json['samples_provided'] as String?,
  competitorActivityNotes: json['competitor_activity_notes'] as String?,
  prescriptionPotentialNotes: json['prescription_potential_notes'] as String?,
  nextVisitDate: json['next_visit_date'] == null
      ? null
      : DateTime.parse(json['next_visit_date'] as String),
  nextVisitObjective: json['next_visit_objective'] as String?,
  linkedSaleOrderId: json['linked_sale_order_id'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$MrVisitLogToJson(_MrVisitLog instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mr_user_id': instance.mrUserId,
      'doctor_id': instance.doctorId,
      'visit_date': instance.visitDate.toIso8601String(),
      'products_detailed': instance.productsDetailed,
      'feedback_received': instance.feedbackReceived,
      'samples_provided': instance.samplesProvided,
      'competitor_activity_notes': instance.competitorActivityNotes,
      'prescription_potential_notes': instance.prescriptionPotentialNotes,
      'next_visit_date': instance.nextVisitDate?.toIso8601String(),
      'next_visit_objective': instance.nextVisitObjective,
      'linked_sale_order_id': instance.linkedSaleOrderId,
      'created_at': instance.createdAt.toIso8601String(),
    };

_CreateVisitLogRequest _$CreateVisitLogRequestFromJson(
  Map<String, dynamic> json,
) => _CreateVisitLogRequest(
  doctorId: json['doctor_id'] as String,
  visitDate: DateTime.parse(json['visit_date'] as String),
  productsDetailed: json['products_detailed'] as String?,
  feedbackReceived: json['feedback_received'] as String?,
  nextVisitDate: json['next_visit_date'] == null
      ? null
      : DateTime.parse(json['next_visit_date'] as String),
  nextVisitObjective: json['next_visit_objective'] as String?,
);

Map<String, dynamic> _$CreateVisitLogRequestToJson(
  _CreateVisitLogRequest instance,
) => <String, dynamic>{
  'doctor_id': instance.doctorId,
  'visit_date': instance.visitDate.toIso8601String(),
  'products_detailed': instance.productsDetailed,
  'feedback_received': instance.feedbackReceived,
  'next_visit_date': instance.nextVisitDate?.toIso8601String(),
  'next_visit_objective': instance.nextVisitObjective,
};

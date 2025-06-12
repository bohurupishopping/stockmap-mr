// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_clinic_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorClinic _$DoctorClinicFromJson(Map<String, dynamic> json) => DoctorClinic(
  id: json['id'] as String,
  doctorId: json['doctor_id'] as String,
  clinicName: json['clinic_name'] as String,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  isPrimary: json['is_primary'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$DoctorClinicToJson(DoctorClinic instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctor_id': instance.doctorId,
      'clinic_name': instance.clinicName,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'is_primary': instance.isPrimary,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

CreateDoctorClinicRequest _$CreateDoctorClinicRequestFromJson(
  Map<String, dynamic> json,
) => CreateDoctorClinicRequest(
  doctorId: json['doctor_id'] as String,
  clinicName: json['clinic_name'] as String,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  isPrimary: json['is_primary'] as bool? ?? false,
);

Map<String, dynamic> _$CreateDoctorClinicRequestToJson(
  CreateDoctorClinicRequest instance,
) => <String, dynamic>{
  'doctor_id': instance.doctorId,
  'clinic_name': instance.clinicName,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'is_primary': instance.isPrimary,
};

UpdateDoctorClinicRequest _$UpdateDoctorClinicRequestFromJson(
  Map<String, dynamic> json,
) => UpdateDoctorClinicRequest(
  clinicName: json['clinic_name'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  isPrimary: json['is_primary'] as bool?,
);

Map<String, dynamic> _$UpdateDoctorClinicRequestToJson(
  UpdateDoctorClinicRequest instance,
) => <String, dynamic>{
  'clinic_name': instance.clinicName,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'is_primary': instance.isPrimary,
};

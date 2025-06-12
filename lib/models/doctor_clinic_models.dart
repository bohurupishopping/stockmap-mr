import 'package:json_annotation/json_annotation.dart';

part 'doctor_clinic_models.g.dart';

@JsonSerializable()
class DoctorClinic {
  final String id;
  @JsonKey(name: 'doctor_id')
  final String doctorId;
  @JsonKey(name: 'clinic_name')
  final String clinicName;
  final double? latitude;
  final double? longitude;
  @JsonKey(name: 'is_primary')
  final bool isPrimary;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  const DoctorClinic({
    required this.id,
    required this.doctorId,
    required this.clinicName,
    this.latitude,
    this.longitude,
    required this.isPrimary,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DoctorClinic.fromJson(Map<String, dynamic> json) => _$DoctorClinicFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorClinicToJson(this);

  DoctorClinic copyWith({
    String? id,
    String? doctorId,
    String? clinicName,
    double? latitude,
    double? longitude,
    bool? isPrimary,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DoctorClinic(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      clinicName: clinicName ?? this.clinicName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isPrimary: isPrimary ?? this.isPrimary,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'DoctorClinic(id: $id, doctorId: $doctorId, clinicName: $clinicName, latitude: $latitude, longitude: $longitude, isPrimary: $isPrimary)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DoctorClinic &&
        other.id == id &&
        other.doctorId == doctorId &&
        other.clinicName == clinicName &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.isPrimary == isPrimary;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        doctorId.hashCode ^
        clinicName.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        isPrimary.hashCode;
  }
}

@JsonSerializable()
class CreateDoctorClinicRequest {
  @JsonKey(name: 'doctor_id')
  final String doctorId;
  @JsonKey(name: 'clinic_name')
  final String clinicName;
  final double? latitude;
  final double? longitude;
  @JsonKey(name: 'is_primary')
  final bool isPrimary;

  const CreateDoctorClinicRequest({
    required this.doctorId,
    required this.clinicName,
    this.latitude,
    this.longitude,
    this.isPrimary = false,
  });

  factory CreateDoctorClinicRequest.fromJson(Map<String, dynamic> json) => _$CreateDoctorClinicRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateDoctorClinicRequestToJson(this);
}

@JsonSerializable()
class UpdateDoctorClinicRequest {
  @JsonKey(name: 'clinic_name')
  final String? clinicName;
  final double? latitude;
  final double? longitude;
  @JsonKey(name: 'is_primary')
  final bool? isPrimary;

  const UpdateDoctorClinicRequest({
    this.clinicName,
    this.latitude,
    this.longitude,
    this.isPrimary,
  });

  factory UpdateDoctorClinicRequest.fromJson(Map<String, dynamic> json) => _$UpdateDoctorClinicRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateDoctorClinicRequestToJson(this);
}
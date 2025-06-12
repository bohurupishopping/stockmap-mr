import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/doctor_models.dart';
import '../../models/doctor_clinic_models.dart';

part 'doctor_state.freezed.dart';

@freezed
class DoctorState with _$DoctorState {
  const factory DoctorState.initial() = DoctorInitial;
  
  const factory DoctorState.loading() = DoctorLoading;
  
  const factory DoctorState.loaded({
    required List<Doctor> doctors,
    @Default('') String searchQuery,
  }) = DoctorLoaded;
  
  const factory DoctorState.error({
    required String message,
  }) = DoctorError;
}

@freezed
class DoctorDetailState with _$DoctorDetailState {
  const factory DoctorDetailState.initial() = DoctorDetailInitial;
  
  const factory DoctorDetailState.loading() = DoctorDetailLoading;
  
  const factory DoctorDetailState.loaded({
    required Doctor doctor,
    required List<MrVisitLog> visitHistory,
    @Default([]) List<DoctorClinic> clinics,
  }) = DoctorDetailLoaded;
  
  const factory DoctorDetailState.error({
    required String message,
  }) = DoctorDetailError;
}

@freezed
class VisitLogState with _$VisitLogState {
  const factory VisitLogState.initial() = VisitLogInitial;
  
  const factory VisitLogState.loading() = VisitLogLoading;
  
  const factory VisitLogState.success() = VisitLogSuccess;
  
  const factory VisitLogState.error({
    required String message,
  }) = VisitLogError;
}
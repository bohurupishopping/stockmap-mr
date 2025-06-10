import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/doctor_models.dart';
import '../../services/doctor_service.dart';
import 'doctor_state.dart';

class DoctorDetailCubit extends Cubit<DoctorDetailState> {
  DoctorDetailCubit() : super(const DoctorDetailState.initial());

  /// Load doctor details and visit history
  Future<void> loadDoctorDetail(String doctorId) async {
    try {
      log('DoctorDetailCubit: Loading doctor detail for ID: $doctorId');
      emit(const DoctorDetailState.loading());
      
      // Load doctor info and visit history in parallel
      final results = await Future.wait([
        DoctorService.getDoctorById(doctorId),
        DoctorService.getVisitHistory(doctorId),
      ]);
      
      final doctor = results[0] as Doctor;
      final visitHistory = results[1] as List<MrVisitLog>;
      
      emit(DoctorDetailState.loaded(
        doctor: doctor,
        visitHistory: visitHistory,
      ));
      
      log('DoctorDetailCubit: Successfully loaded doctor detail with ${visitHistory.length} visits');
    } catch (e) {
      log('DoctorDetailCubit: Error loading doctor detail: $e');
      emit(DoctorDetailState.error(message: e.toString()));
    }
  }

  /// Refresh visit history only
  Future<void> refreshVisitHistory(String doctorId) async {
    final currentState = state;
    if (currentState is! DoctorDetailLoaded) return;
    
    try {
      log('DoctorDetailCubit: Refreshing visit history for doctor: $doctorId');
      
      final visitHistory = await DoctorService.getVisitHistory(doctorId);
      
      emit(currentState.copyWith(visitHistory: visitHistory));
      
      log('DoctorDetailCubit: Successfully refreshed visit history');
    } catch (e) {
      log('DoctorDetailCubit: Error refreshing visit history: $e');
      // Don't emit error state, just log the error to maintain current state
    }
  }
}

class VisitLogCubit extends Cubit<VisitLogState> {
  VisitLogCubit() : super(const VisitLogState.initial());

  /// Create a new visit log
  Future<void> createVisitLog(CreateVisitLogRequest request) async {
    try {
      log('VisitLogCubit: Creating new visit log');
      emit(const VisitLogState.loading());
      
      await DoctorService.createVisitLog(request);
      
      emit(const VisitLogState.success());
      log('VisitLogCubit: Successfully created visit log');
    } catch (e) {
      log('VisitLogCubit: Error creating visit log: $e');
      emit(VisitLogState.error(message: e.toString()));
    }
  }

  /// Reset state to initial
  void reset() {
    emit(const VisitLogState.initial());
  }
}
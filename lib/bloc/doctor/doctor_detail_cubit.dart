import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/doctor_models.dart';
import '../../models/doctor_clinic_models.dart';
import '../../services/doctor_service.dart';
import 'doctor_state.dart';

class DoctorDetailCubit extends Cubit<DoctorDetailState> {
  DoctorDetailCubit() : super(const DoctorDetailState.initial());

  /// Load doctor details, visit history, and clinics
  Future<void> loadDoctorDetail(String doctorId) async {
    try {
      log('DoctorDetailCubit: Loading doctor detail for ID: $doctorId');
      emit(const DoctorDetailState.loading());
      
      // Load doctor info, visit history, and clinics in parallel
      final results = await Future.wait([
        DoctorService.getDoctorById(doctorId),
        DoctorService.getVisitHistory(doctorId),
        DoctorService.getDoctorClinics(doctorId),
      ]);
      
      final doctor = results[0] as Doctor;
      final visitHistory = results[1] as List<MrVisitLog>;
      final clinics = results[2] as List<DoctorClinic>;
      
      emit(DoctorDetailState.loaded(
        doctor: doctor,
        visitHistory: visitHistory,
        clinics: clinics,
      ));
      
      log('DoctorDetailCubit: Successfully loaded doctor detail with ${visitHistory.length} visits and ${clinics.length} clinics');
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

  /// Refresh clinics only
  Future<void> refreshClinics(String doctorId) async {
    final currentState = state;
    if (currentState is! DoctorDetailLoaded) return;
    
    try {
      log('DoctorDetailCubit: Refreshing clinics for doctor: $doctorId');
      
      final clinics = await DoctorService.getDoctorClinics(doctorId);
      
      emit(currentState.copyWith(clinics: clinics));
      
      log('DoctorDetailCubit: Successfully refreshed clinics');
    } catch (e) {
      log('DoctorDetailCubit: Error refreshing clinics: $e');
      // Don't emit error state, just log the error to maintain current state
    }
  }

  /// Update doctor information
  Future<void> updateDoctor(String doctorId, Map<String, dynamic> updateData) async {
    final currentState = state;
    if (currentState is! DoctorDetailLoaded) return;
    
    try {
      log('DoctorDetailCubit: Updating doctor: $doctorId');
      
      final updatedDoctor = await DoctorService.updateDoctor(doctorId, updateData);
      
      emit(currentState.copyWith(doctor: updatedDoctor));
      
      log('DoctorDetailCubit: Successfully updated doctor');
    } catch (e) {
      log('DoctorDetailCubit: Error updating doctor: $e');
      emit(DoctorDetailState.error(message: e.toString()));
    }
  }

  /// Create a new clinic
  Future<void> createClinic(CreateDoctorClinicRequest request) async {
    final currentState = state;
    if (currentState is! DoctorDetailLoaded) return;
    
    try {
      log('DoctorDetailCubit: Creating new clinic for doctor: ${request.doctorId}');
      
      await DoctorService.createDoctorClinic(request);
      
      // Refresh clinics to get the updated list
      await refreshClinics(request.doctorId);
      
      log('DoctorDetailCubit: Successfully created clinic');
    } catch (e) {
      log('DoctorDetailCubit: Error creating clinic: $e');
      emit(DoctorDetailState.error(message: e.toString()));
    }
  }

  /// Update an existing clinic
  Future<void> updateClinic(String clinicId, String doctorId, UpdateDoctorClinicRequest request) async {
    final currentState = state;
    if (currentState is! DoctorDetailLoaded) return;
    
    try {
      log('DoctorDetailCubit: Updating clinic: $clinicId');
      
      await DoctorService.updateDoctorClinic(clinicId, request);
      
      // Refresh clinics to get the updated list
      await refreshClinics(doctorId);
      
      log('DoctorDetailCubit: Successfully updated clinic');
    } catch (e) {
      log('DoctorDetailCubit: Error updating clinic: $e');
      emit(DoctorDetailState.error(message: e.toString()));
    }
  }

  /// Delete a clinic
  Future<void> deleteClinic(String clinicId, String doctorId) async {
    final currentState = state;
    if (currentState is! DoctorDetailLoaded) return;
    
    try {
      log('DoctorDetailCubit: Deleting clinic: $clinicId');
      
      await DoctorService.deleteDoctorClinic(clinicId);
      
      // Refresh clinics to get the updated list
      await refreshClinics(doctorId);
      
      log('DoctorDetailCubit: Successfully deleted clinic');
    } catch (e) {
      log('DoctorDetailCubit: Error deleting clinic: $e');
      emit(DoctorDetailState.error(message: e.toString()));
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
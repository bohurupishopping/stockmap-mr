import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/doctor_service.dart';
import 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit() : super(const DoctorState.initial());

  /// Load all doctors assigned to the current MR
  Future<void> loadDoctors() async {
    try {
      log('DoctorCubit: Loading doctors');
      emit(const DoctorState.loading());
      
      final doctors = await DoctorService.getMyDoctors();
      
      emit(DoctorState.loaded(doctors: doctors));
      log('DoctorCubit: Successfully loaded ${doctors.length} doctors');
    } catch (e) {
      log('DoctorCubit: Error loading doctors: $e');
      emit(DoctorState.error(message: e.toString()));
    }
  }

  /// Search doctors by name
  Future<void> searchDoctors(String query) async {
    try {
      log('DoctorCubit: Searching doctors with query: $query');
      
      if (query.isEmpty) {
        // If query is empty, load all doctors
        await loadDoctors();
        return;
      }
      
      emit(const DoctorState.loading());
      
      final doctors = await DoctorService.searchDoctors(query);
      
      emit(DoctorState.loaded(
        doctors: doctors,
        searchQuery: query,
      ));
      log('DoctorCubit: Found ${doctors.length} doctors matching query');
    } catch (e) {
      log('DoctorCubit: Error searching doctors: $e');
      emit(DoctorState.error(message: e.toString()));
    }
  }

  /// Clear search and reload all doctors
  Future<void> clearSearch() async {
    await loadDoctors();
  }

  /// Create a new doctor
  Future<void> createDoctor(Map<String, dynamic> doctorData) async {
    try {
      log('DoctorCubit: Creating new doctor');
      emit(const DoctorState.loading());
      
      final doctor = await DoctorService.createDoctor(doctorData);
      
      log('DoctorCubit: Successfully created doctor: ${doctor.fullName}');
      
      // Reload the doctors list to include the new doctor
      await loadDoctors();
    } catch (e) {
      log('DoctorCubit: Error creating doctor: $e');
      emit(DoctorState.error(message: e.toString()));
    }
  }
}
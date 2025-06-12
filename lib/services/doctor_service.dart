import 'dart:developer';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/doctor_models.dart';
import '../models/doctor_clinic_models.dart';

class DoctorService {
  static final _supabase = Supabase.instance.client;

  /// Get all doctors assigned to the current MR
  static Future<List<Doctor>> getMyDoctors() async {
    try {
      log('DoctorService: Fetching doctors for current MR');
      
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      // First, get the doctor IDs assigned to the current MR
      final allotmentResponse = await _supabase
          .from('mr_doctor_allotments')
          .select('doctor_id')
          .eq('mr_user_id', userId);

      if (allotmentResponse.isEmpty) {
        log('DoctorService: No doctors assigned to this MR');
        return [];
      }

      final doctorIds = (allotmentResponse as List<dynamic>)
          .map((item) => item['doctor_id'] as String)
          .toList();

      // Then, get the doctors using the IDs
      final response = await _supabase
          .from('doctors')
          .select('''
            id,
            full_name,
            specialty,
            clinic_address,
            phone_number,
            email,
            date_of_birth,
            anniversary_date,
            tier,
            latitude,
            longitude,
            is_active,
            created_at,
            updated_at,
            created_by
          ''')
          .inFilter('id', doctorIds)
          .eq('is_active', true)
          .order('full_name');

      log('DoctorService: Received ${response.length} doctors');
      
      return (response as List<dynamic>)
          .map((json) => Doctor.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('DoctorService: Error fetching doctors: $e');
      rethrow;
    }
  }

  /// Get a specific doctor by ID
  static Future<Doctor> getDoctorById(String doctorId) async {
    try {
      log('DoctorService: Fetching doctor with ID: $doctorId');
      
      final response = await _supabase
          .from('doctors')
          .select('''
            id,
            full_name,
            specialty,
            clinic_address,
            phone_number,
            email,
            date_of_birth,
            anniversary_date,
            tier,
            latitude,
            longitude,
            is_active,
            created_at,
            updated_at,
            created_by
          ''')
          .eq('id', doctorId)
          .single();

      log('DoctorService: Successfully fetched doctor');
      
      return Doctor.fromJson(response);
    } catch (e) {
      log('DoctorService: Error fetching doctor: $e');
      rethrow;
    }
  }

  /// Get visit history for a specific doctor
  static Future<List<MrVisitLog>> getVisitHistory(String doctorId) async {
    try {
      log('DoctorService: Fetching visit history for doctor: $doctorId');
      
      final response = await _supabase
          .from('mr_visit_logs')
          .select('''
            id,
            mr_user_id,
            doctor_id,
            visit_date,
            products_detailed,
            feedback_received,
            samples_provided,
            competitor_activity_notes,
            prescription_potential_notes,
            next_visit_date,
            next_visit_objective,
            linked_sale_order_id,
            is_location_verified,
            distance_from_clinic_meters,
            created_at
          ''')
          .eq('doctor_id', doctorId)
          .order('visit_date', ascending: false);

      log('DoctorService: Received ${response.length} visit logs');
      
      return (response as List<dynamic>)
          .map((json) => MrVisitLog.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('DoctorService: Error fetching visit history: $e');
      rethrow;
    }
  }

  /// Create a new visit log
  static Future<MrVisitLog> createVisitLog(CreateVisitLogRequest request) async {
    try {
      log('DoctorService: Creating new visit log');
      
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final visitData = {
        'mr_user_id': userId,
        'doctor_id': request.doctorId,
        'visit_date': request.visitDate.toIso8601String(),
        'products_detailed': request.productsDetailed,
        'feedback_received': request.feedbackReceived,
        'next_visit_date': request.nextVisitDate?.toIso8601String(),
        'next_visit_objective': request.nextVisitObjective,
        'is_location_verified': request.isLocationVerified,
        'distance_from_clinic_meters': request.distanceFromClinicMeters,
      };

      final response = await _supabase
          .from('mr_visit_logs')
          .insert(visitData)
          .select('''
            id,
            mr_user_id,
            doctor_id,
            visit_date,
            products_detailed,
            feedback_received,
            samples_provided,
            competitor_activity_notes,
            prescription_potential_notes,
            next_visit_date,
            next_visit_objective,
            linked_sale_order_id,
            is_location_verified,
            distance_from_clinic_meters,
            created_at
          ''')
          .single();

      log('DoctorService: Successfully created visit log');
      
      return MrVisitLog.fromJson(response);
    } catch (e) {
      log('DoctorService: Error creating visit log: $e');
      rethrow;
    }
  }

  /// Search doctors by name
  static Future<List<Doctor>> searchDoctors(String query) async {
    try {
      log('DoctorService: Searching doctors with query: $query');
      
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      // First, get the doctor IDs assigned to the current MR
      final allotmentResponse = await _supabase
          .from('mr_doctor_allotments')
          .select('doctor_id')
          .eq('mr_user_id', userId);

      if (allotmentResponse.isEmpty) {
        log('DoctorService: No doctors assigned to this MR');
        return [];
      }

      final doctorIds = (allotmentResponse as List<dynamic>)
          .map((item) => item['doctor_id'] as String)
          .toList();

      // Then, search doctors using the IDs and query
      final response = await _supabase
          .from('doctors')
          .select('''
            id,
            full_name,
            specialty,
            clinic_address,
            phone_number,
            email,
            date_of_birth,
            anniversary_date,
            tier,
            latitude,
            longitude,
            is_active,
            created_at,
            updated_at,
            created_by
          ''')
          .inFilter('id', doctorIds)
          .eq('is_active', true)
          .ilike('full_name', '%$query%')
          .order('full_name');

      log('DoctorService: Found ${response.length} doctors matching query');
      
      return (response as List<dynamic>)
          .map((json) => Doctor.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('DoctorService: Error searching doctors: $e');
      rethrow;
    }
  }

  /// Create a new doctor
  static Future<Doctor> createDoctor(Map<String, dynamic> doctorData) async {
    try {
      log('DoctorService: Creating new doctor');
      
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      // Add created_by field
      doctorData['created_by'] = userId;
      doctorData['is_active'] = true;

      // Create the doctor
      final response = await _supabase
          .from('doctors')
          .insert(doctorData)
          .select('''
            id,
            full_name,
            specialty,
            clinic_address,
            phone_number,
            email,
            date_of_birth,
            anniversary_date,
            tier,
            latitude,
            longitude,
            is_active,
            created_at,
            updated_at,
            created_by
          ''')
          .single();

      final doctor = Doctor.fromJson(response);
      
      // Automatically assign the doctor to the current MR
      await _supabase
          .from('mr_doctor_allotments')
          .insert({
            'mr_user_id': userId,
            'doctor_id': doctor.id,
          });

      log('DoctorService: Successfully created doctor and assigned to MR');
      
      return doctor;
    } catch (e) {
      log('DoctorService: Error creating doctor: $e');
      rethrow;
    }
  }

  /// Get all clinics for a specific doctor
  static Future<List<DoctorClinic>> getDoctorClinics(String doctorId) async {
    try {
      log('DoctorService: Fetching clinics for doctor: $doctorId');
      
      final response = await _supabase
          .from('doctor_clinics')
          .select('''
            id,
            doctor_id,
            clinic_name,
            latitude,
            longitude,
            is_primary,
            created_at,
            updated_at
          ''')
          .eq('doctor_id', doctorId)
          .order('is_primary', ascending: false)
          .order('clinic_name');

      log('DoctorService: Received ${response.length} clinics');
      
      return (response as List<dynamic>)
          .map((json) => DoctorClinic.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('DoctorService: Error fetching doctor clinics: $e');
      rethrow;
    }
  }

  /// Create a new clinic for a doctor
  static Future<DoctorClinic> createDoctorClinic(CreateDoctorClinicRequest request) async {
    try {
      log('DoctorService: Creating new clinic for doctor: ${request.doctorId}');
      
      final clinicData = {
        'doctor_id': request.doctorId,
        'clinic_name': request.clinicName,
        'latitude': request.latitude,
        'longitude': request.longitude,
        'is_primary': request.isPrimary,
      };

      final response = await _supabase
          .from('doctor_clinics')
          .insert(clinicData)
          .select('''
            id,
            doctor_id,
            clinic_name,
            latitude,
            longitude,
            is_primary,
            created_at,
            updated_at
          ''')
          .single();

      log('DoctorService: Successfully created clinic');
      
      return DoctorClinic.fromJson(response);
    } catch (e) {
      log('DoctorService: Error creating clinic: $e');
      rethrow;
    }
  }

  /// Update an existing clinic
  static Future<DoctorClinic> updateDoctorClinic(String clinicId, UpdateDoctorClinicRequest request) async {
    try {
      log('DoctorService: Updating clinic: $clinicId');
      
      final updateData = <String, dynamic>{};
      if (request.clinicName != null) updateData['clinic_name'] = request.clinicName;
      if (request.latitude != null) updateData['latitude'] = request.latitude;
      if (request.longitude != null) updateData['longitude'] = request.longitude;
      if (request.isPrimary != null) updateData['is_primary'] = request.isPrimary;
      
      updateData['updated_at'] = DateTime.now().toIso8601String();

      final response = await _supabase
          .from('doctor_clinics')
          .update(updateData)
          .eq('id', clinicId)
          .select('''
            id,
            doctor_id,
            clinic_name,
            latitude,
            longitude,
            is_primary,
            created_at,
            updated_at
          ''')
          .single();

      log('DoctorService: Successfully updated clinic');
      
      return DoctorClinic.fromJson(response);
    } catch (e) {
      log('DoctorService: Error updating clinic: $e');
      rethrow;
    }
  }

  /// Delete a clinic
  static Future<void> deleteDoctorClinic(String clinicId) async {
    try {
      log('DoctorService: Deleting clinic: $clinicId');
      
      await _supabase
          .from('doctor_clinics')
          .delete()
          .eq('id', clinicId);

      log('DoctorService: Successfully deleted clinic');
    } catch (e) {
      log('DoctorService: Error deleting clinic: $e');
      rethrow;
    }
  }

  /// Update a doctor's basic information
  static Future<Doctor> updateDoctor(String doctorId, Map<String, dynamic> updateData) async {
    try {
      log('DoctorService: Updating doctor: $doctorId');
      
      updateData['updated_at'] = DateTime.now().toIso8601String();

      final response = await _supabase
          .from('doctors')
          .update(updateData)
          .eq('id', doctorId)
          .select('''
            id,
            full_name,
            specialty,
            clinic_address,
            phone_number,
            email,
            date_of_birth,
            anniversary_date,
            tier,
            latitude,
            longitude,
            is_active,
            created_at,
            updated_at,
            created_by
          ''')
          .single();

      log('DoctorService: Successfully updated doctor');
      
      return Doctor.fromJson(response);
    } catch (e) {
      log('DoctorService: Error updating doctor: $e');
      rethrow;
    }
  }
}
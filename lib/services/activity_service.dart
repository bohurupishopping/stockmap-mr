import 'dart:developer';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/doctor_models.dart';

class ActivityService {
  static final _supabase = Supabase.instance.client;

  /// Get daily activity data for the current MR
  static Future<Map<String, List<dynamic>>> getDailyActivityData() async {
    try {
      log('ActivityService: Fetching daily activity data');
      
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final today = DateTime.now();
      final todayStart = DateTime(today.year, today.month, today.day);
      final todayEnd = DateTime(today.year, today.month, today.day, 23, 59, 59);

      // --- QUERY 1: Fetch TO-DO Visits ---
      // Gets visits that were scheduled for today
      final todoVisitsResponse = await _supabase
          .from('mr_visit_logs')
          .select('''
            doctor_id,
            next_visit_objective,
            doctors!inner(
              id,
              full_name
            )
          ''')
          .eq('mr_user_id', userId)
          .eq('next_visit_date', todayStart.toIso8601String().split('T')[0]);

      // --- QUERY 2: Fetch COMPLETED Visits ---
      // Gets visits that were actually created/logged today
      final completedVisitsResponse = await _supabase
          .from('mr_visit_logs')
          .select('''
            doctor_id,
            products_detailed,
            feedback_received,
            visit_date,
            doctors!inner(
              id,
              full_name
            )
          ''')
          .eq('mr_user_id', userId)
          .gte('visit_date', todayStart.toIso8601String())
          .lte('visit_date', todayEnd.toIso8601String());

      // --- QUERY 3: Fetch ENGAGEMENTS (Birthdays/Anniversaries) ---
      // Gets doctors whose special day is today
      
      // 1. Get all of the MR's allotted doctor IDs
      final allotmentsResponse = await _supabase
          .from('mr_doctor_allotments')
          .select('doctor_id')
          .eq('mr_user_id', userId);

      final doctorIds = (allotmentsResponse as List<dynamic>)
          .map((row) => row['doctor_id'] as String)
          .toList();

      // 2. Query the doctors table for those IDs with birthday/anniversary today
      List<dynamic> engagementResponse = [];
      if (doctorIds.isNotEmpty) {
        // Use proper date functions to compare month and day
        final todayMonth = today.month;
        final todayDay = today.day;
        
        // Since PostgREST doesn't support complex date extraction in filters easily,
        // we'll fetch all doctors and filter in Dart
        final allDoctorsResponse = await _supabase
            .from('doctors')
            .select('''
              id,
              full_name,
              date_of_birth,
              anniversary_date
            ''')
            .inFilter('id', doctorIds);

        // Filter doctors with birthdays or anniversaries today
        engagementResponse = allDoctorsResponse.where((doctor) {
          final dateOfBirth = doctor['date_of_birth'] as String?;
          final anniversaryDate = doctor['anniversary_date'] as String?;
          
          bool hasBirthdayToday = false;
          bool hasAnniversaryToday = false;
          
          if (dateOfBirth != null) {
            final birthDate = DateTime.parse(dateOfBirth);
            hasBirthdayToday = birthDate.month == todayMonth && birthDate.day == todayDay;
          }
          
          if (anniversaryDate != null) {
            final anniversary = DateTime.parse(anniversaryDate);
            hasAnniversaryToday = anniversary.month == todayMonth && anniversary.day == todayDay;
          }
          
          return hasBirthdayToday || hasAnniversaryToday;
        }).toList();
      }

      log('ActivityService: Todo visits: ${todoVisitsResponse.length}');
      log('ActivityService: Completed visits: ${completedVisitsResponse.length}');
      log('ActivityService: Engagements: ${engagementResponse.length}');

      // --- Combine and Return Data for the UI ---
      return {
        'todo_visits': todoVisitsResponse,
        'completed_visits': completedVisitsResponse,
        'engagements': engagementResponse,
      };
    } catch (e) {
      log('ActivityService: Error fetching daily activity data: $e');
      rethrow;
    }
  }

  /// Get visit details for a specific doctor
  static Future<List<MrVisitLog>> getDoctorVisitHistory(String doctorId) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final response = await _supabase
          .from('mr_visit_logs')
          .select('*')
          .eq('mr_user_id', userId)
          .eq('doctor_id', doctorId)
          .order('visit_date', ascending: false)
          .limit(10);

      return (response as List<dynamic>)
          .map((json) => MrVisitLog.fromJson(json))
          .toList();
    } catch (e) {
      log('ActivityService: Error fetching doctor visit history: $e');
      rethrow;
    }
  }

  /// Create a new visit log
  static Future<void> logVisit({
    required String doctorId,
    String? productsDetailed,
    String? feedbackReceived,
    String? samplesProvided,
    String? competitorActivityNotes,
    String? prescriptionPotentialNotes,
    DateTime? nextVisitDate,
    String? nextVisitObjective,
  }) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      await _supabase.from('mr_visit_logs').insert({
        'mr_user_id': userId,
        'doctor_id': doctorId,
        'visit_date': DateTime.now().toIso8601String(),
        'products_detailed': productsDetailed,
        'feedback_received': feedbackReceived,
        'samples_provided': samplesProvided,
        'competitor_activity_notes': competitorActivityNotes,
        'prescription_potential_notes': prescriptionPotentialNotes,
        'next_visit_date': nextVisitDate?.toIso8601String().split('T')[0],
        'next_visit_objective': nextVisitObjective,
      });

      log('ActivityService: Visit logged successfully for doctor: $doctorId');
    } catch (e) {
      log('ActivityService: Error logging visit: $e');
      rethrow;
    }
  }
}
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/doctor/doctor_detail_cubit.dart';
import '../bloc/doctor/doctor_state.dart';
import '../models/doctor_models.dart';
import '../models/doctor_clinic_models.dart';
import '../widgets/doctor/new_visit_log_modal.dart';
import '../widgets/doctor/edit_doctor_modal.dart';
import '../widgets/doctor/edit_clinic_modal.dart';

class DoctorDetailPage extends StatefulWidget {
  final String doctorId;

  const DoctorDetailPage({
    super.key,
    required this.doctorId,
  });

  @override
  State<DoctorDetailPage> createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<DoctorDetailCubit>().loadDoctorDetail(widget.doctorId);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      floatingActionButton: BlocBuilder<DoctorDetailCubit, DoctorDetailState>(
        builder: (context, state) {
          if (state is DoctorDetailLoaded) {
            return FloatingActionButton(
              onPressed: () => _showNewVisitModal(state.doctor),
              backgroundColor: const Color(0xFF2563EB),
              child: const Icon(
                Icons.add_rounded,
                color: Colors.white,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      appBar: AppBar(
        title: const Text(
          'Doctor Details',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0xFF2563EB),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: BlocBuilder<DoctorDetailCubit, DoctorDetailState>(
        builder: (context, state) {
          if (state is DoctorDetailInitial || state is DoctorDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
              ),
            );
          } else if (state is DoctorDetailLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<DoctorDetailCubit>().refreshVisitHistory(widget.doctorId);
              },
              color: const Color(0xFF2563EB),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(isTablet ? 20 : 16),
                child: Column(
                  children: [
                    _buildDoctorInfoSection(state.doctor, isTablet),
                    const SizedBox(height: 16),
                    _buildClinicsSection(state.doctor, state.clinics, isTablet),
                    const SizedBox(height: 16),
                    _buildVisitHistorySection(state.doctor, state.visitHistory, isTablet),
                  ],
                ),
              ),
            );
          } else if (state is DoctorDetailError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 48,
                    color: const Color(0xFFEF4444),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(
                      color: Color(0xFFEF4444),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Text('Loading doctor details...'),
          );
        },
      ),
    );
  }


  Widget _buildDoctorInfoSection(Doctor doctor, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Column(
        children: [
          // Header with edit button
          Row(
            children: [
              const Text(
                'Doctor Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E293B),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => _showEditDoctorModal(doctor),
                icon: const Icon(
                  Icons.edit_rounded,
                  size: 20,
                  color: Color(0xFF2563EB),
                ),
                tooltip: 'Edit Doctor',
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Doctor info content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar and Tier
              Column(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2563EB).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFF2563EB).withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.medical_information_rounded,
                        color: Color(0xFF2563EB),
                        size: 28,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildTierBadge(doctor.tier),
                ],
              ),
              const SizedBox(width: 16),
              // Contact Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and Specialty
                    Text(
                      doctor.fullName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    if (doctor.specialty != null) 
                      Text(
                        doctor.specialty!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    const SizedBox(height: 8),
                    // Contact Info in Wrap
                    _buildCompactContactInfo(doctor, isTablet),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompactContactInfo(Doctor doctor, bool isTablet) {
    final contacts = <Map<String, dynamic>>[];
    
    if (doctor.phoneNumber != null && doctor.phoneNumber!.isNotEmpty) {
      contacts.add({
        'icon': Icons.phone_rounded,
        'value': doctor.phoneNumber!,
        'color': const Color(0xFF059669),
      });
    }
    
    if (doctor.email != null && doctor.email!.isNotEmpty) {
      contacts.add({
        'icon': Icons.email_rounded,
        'value': doctor.email!,
        'color': const Color(0xFF7C3AED),
      });
    }
    
    if (doctor.clinicAddress != null && doctor.clinicAddress!.isNotEmpty) {
      contacts.add({
        'icon': Icons.location_on_rounded,
        'value': doctor.clinicAddress!,
        'color': const Color(0xFFDC2626),
      });
    }

    if (contacts.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: contacts.map((contact) => _buildContactChip(contact)).toList(),
    );
  }

  Widget _buildContactChip(Map<String, dynamic> contact) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: (contact['color'] as Color).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: (contact['color'] as Color).withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            contact['icon'] as IconData,
            size: 14,
            color: contact['color'] as Color,
          ),
          const SizedBox(width: 6),
          Text(
            contact['value'] as String,
            style: TextStyle(
              fontSize: 13,
              color: contact['color'] as Color,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }



  Widget _buildTierBadge(DoctorTier? tier) {
    Color tierColor;
    
    switch (tier) {
      case DoctorTier.a:
        tierColor = const Color(0xFF059669);
        break;
      case DoctorTier.b:
        tierColor = const Color(0xFFD97706);
        break;
      case DoctorTier.c:
        tierColor = const Color(0xFFDC2626);
        break;
      default:
        tierColor = const Color(0xFF64748B);
    }

    IconData tierIcon;
    switch (tier) {
      case DoctorTier.a:
        tierIcon = Icons.emoji_events_rounded; // Trophy icon for top tier
        break;
      case DoctorTier.b:
        tierIcon = Icons.verified_rounded; // Verified icon for mid tier
        break;
      case DoctorTier.c:
        tierIcon = Icons.assignment_rounded; // Assignment icon for base tier
        break;
      default:
        tierIcon = Icons.help_outline_rounded;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: tierColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: tierColor.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Icon(
        tierIcon,
        color: tierColor,
        size: 24,
      ),
    );
  }

  Widget _buildVisitHistorySection(Doctor doctor, List<MrVisitLog> visitHistory, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with visit count and action button
          Row(
            children: [
              const Text(
                'Visit History',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${visitHistory.length}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2563EB),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Visit history content
          if (visitHistory.isEmpty)
            _buildEmptyVisitHistory()
          else
            _buildVisitHistoryList(visitHistory, isTablet),
        ],
      ),
    );
  }

  Widget _buildEmptyVisitHistory() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF2563EB).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.event_note_rounded,
              size: 28,
              color: Color(0xFF2563EB),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No visits recorded',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Start building relationships by logging your first visit',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildVisitHistoryList(List<MrVisitLog> visitHistory, bool isTablet) {
    return isTablet 
      ? Wrap(
          spacing: 16,
          runSpacing: 16,
          children: visitHistory.map((visit) => 
            SizedBox(
              width: (MediaQuery.of(context).size.width - 64) / 2,
              child: _VisitCard(
                visit: visit, 
                isTablet: true,
                onEdit: () => _showEditVisitModal(visit),
              ),
            )
          ).toList(),
        )
      : ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: visitHistory.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final visit = visitHistory[index];
            return _VisitCard(
              visit: visit, 
              isTablet: false,
              onEdit: () => _showEditVisitModal(visit),
            );
          },
        );
  }


  Widget _buildClinicsSection(Doctor doctor, List<DoctorClinic> clinics, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with clinic count and add button
          Row(
            children: [
              const Text(
                'Clinic Locations',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${clinics.length}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2563EB),
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => _showAddClinicModal(doctor),
                icon: const Icon(
                  Icons.add_location_rounded,
                  size: 20,
                  color: Color(0xFF2563EB),
                ),
                tooltip: 'Add Clinic',
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Clinics content
          if (clinics.isEmpty)
            _buildEmptyClinics()
          else
            _buildClinicsList(doctor, clinics, isTablet),
        ],
      ),
    );
  }

  Widget _buildEmptyClinics() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF2563EB).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.location_on_rounded,
              size: 28,
              color: Color(0xFF2563EB),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No clinic locations added',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add clinic locations to track multiple practice sites',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF94A3B8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildClinicsList(Doctor doctor, List<DoctorClinic> clinics, bool isTablet) {
    return Column(
      children: clinics.map((clinic) => _buildClinicCard(doctor, clinic, isTablet)).toList(),
    );
  }

  Widget _buildClinicCard(Doctor doctor, DoctorClinic clinic, bool isTablet) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: clinic.isPrimary ? const Color(0xFF2563EB).withOpacity(0.05) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: clinic.isPrimary ? const Color(0xFF2563EB).withOpacity(0.2) : const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Clinic icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: clinic.isPrimary ? const Color(0xFF2563EB).withOpacity(0.1) : const Color(0xFF64748B).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              clinic.isPrimary ? Icons.home_work_rounded : Icons.location_on_rounded,
              size: 20,
              color: clinic.isPrimary ? const Color(0xFF2563EB) : const Color(0xFF64748B),
            ),
          ),
          const SizedBox(width: 12),
          // Clinic details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      clinic.clinicName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    if (clinic.isPrimary) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2563EB),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'PRIMARY',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                if (clinic.latitude != null && clinic.longitude != null)
                  Text(
                    'Lat: ${clinic.latitude!.toStringAsFixed(6)}, Lng: ${clinic.longitude!.toStringAsFixed(6)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
              ],
            ),
          ),
          // Action buttons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => _showEditClinicModal(doctor, clinic),
                icon: const Icon(
                  Icons.edit_rounded,
                  size: 18,
                  color: Color(0xFF2563EB),
                ),
                tooltip: 'Edit Clinic',
              ),
              if (!clinic.isPrimary)
                IconButton(
                  onPressed: () => _showDeleteClinicDialog(doctor, clinic),
                  icon: const Icon(
                    Icons.delete_rounded,
                    size: 18,
                    color: Color(0xFFEF4444),
                  ),
                  tooltip: 'Delete Clinic',
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _showNewVisitModal(Doctor doctor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => NewVisitLogModal(
        doctorId: widget.doctorId,
        doctor: doctor,
        onSuccess: () {
          // Refresh visit history after successful creation
          context.read<DoctorDetailCubit>().refreshVisitHistory(widget.doctorId);
        },
      ),
    );
  }

  void _showEditVisitModal(MrVisitLog visitLog) {
    final state = context.read<DoctorDetailCubit>().state;
    if (state is DoctorDetailLoaded) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => NewVisitLogModal.edit(
          doctorId: widget.doctorId,
          doctor: state.doctor,
          existingVisitLog: visitLog,
          onSuccess: () {
            context.read<DoctorDetailCubit>().refreshVisitHistory(widget.doctorId);
          },
        ),
      );
    }
  }

  void _showEditDoctorModal(Doctor doctor) {
    showDialog(
      context: context,
      builder: (context) => EditDoctorModal(
        doctor: doctor,
        onDoctorUpdated: () {
          context.read<DoctorDetailCubit>().loadDoctorDetail(doctor.id);
        },
      ),
    );
  }

  void _showAddClinicModal(Doctor doctor) {
    showDialog(
      context: context,
      builder: (context) => EditClinicModal(
        doctorId: doctor.id,
        onClinicUpdated: () {
          context.read<DoctorDetailCubit>().refreshClinics(doctor.id);
        },
      ),
    );
  }

  void _showEditClinicModal(Doctor doctor, DoctorClinic clinic) {
    showDialog(
      context: context,
      builder: (context) => EditClinicModal(
        doctorId: doctor.id,
        clinic: clinic,
        onClinicUpdated: () {
          context.read<DoctorDetailCubit>().refreshClinics(doctor.id);
        },
      ),
    );
  }

  void _showDeleteClinicDialog(Doctor doctor, DoctorClinic clinic) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Clinic'),
        content: Text('Are you sure you want to delete "${clinic.clinicName}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<DoctorDetailCubit>().deleteClinic(clinic.id, doctor.id);
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFEF4444),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _VisitCard extends StatelessWidget {
  final MrVisitLog visit;
  final bool isTablet;
  final VoidCallback? onEdit;

  const _VisitCard({required this.visit, this.isTablet = false, this.onEdit});

  @override
  Widget build(BuildContext context) {
    final hasProducts = visit.productsDetailed != null && visit.productsDetailed!.isNotEmpty;
    final hasFeedback = visit.feedbackReceived != null && visit.feedbackReceived!.isNotEmpty;
    final hasNextVisit = visit.nextVisitDate != null;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFBFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date and status in one row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.event_rounded,
                  size: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      DateFormat('MMM dd, yyyy • ').format(visit.visitDate),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      DateFormat('h:mm a').format(visit.visitDate),
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF059669).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF059669),
                      ),
                    ),
                  ),
                  if (onEdit != null) ...[
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onEdit,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2563EB).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.edit_rounded,
                          size: 14,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          
          // Content chips
          if (hasProducts || hasFeedback) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (hasProducts)
                  _buildContentChip(
                    'Products',
                    visit.productsDetailed!,
                    Icons.medical_services_rounded,
                    const Color(0xFF7C3AED),
                  ),
                if (hasFeedback)
                  _buildContentChip(
                    'Feedback',
                    visit.feedbackReceived!,
                    Icons.feedback_rounded,
                    const Color(0xFF0891B2),
                  ),
              ],
            ),
          ],
          
          // Next visit chip
          if (hasNextVisit) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFD97706).withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: const Color(0xFFD97706).withOpacity(0.2),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.schedule_rounded,
                    size: 14,
                    color: const Color(0xFFD97706),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Next: ${DateFormat('MMM dd, yyyy').format(visit.nextVisitDate!)}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFD97706),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildContentChip(String title, String content, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: color.withOpacity(0.15),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              content,
              style: TextStyle(
                fontSize: 12,
                color: color.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

}

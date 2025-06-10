// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/doctor/doctor_detail_cubit.dart';
import '../bloc/doctor/doctor_state.dart';
import '../models/doctor_models.dart';
import '../widgets/doctor/new_visit_log_modal.dart';

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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Column(
        children: [
          // Compact header row with all main info
          Row(
            children: [
              // Avatar
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    doctor.fullName.split(' ').map((e) => e[0]).take(2).join(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Name and specialty
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.fullName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    if (doctor.specialty != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        doctor.specialty!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Tier badge
              _buildTierBadge(doctor.tier),
            ],
          ),
          const SizedBox(height: 20),
          // Compact contact info
          _buildCompactContactInfo(doctor, isTablet),
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

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: isTablet && contacts.length > 1
          ? Wrap(
              spacing: 24,
              runSpacing: 12,
              children: contacts.map((contact) => _buildContactItem(contact)).toList(),
            )
          : Column(
              children: contacts
                  .map((contact) => Padding(
                        padding: EdgeInsets.only(
                          bottom: contact == contacts.last ? 0 : 12,
                        ),
                        child: _buildContactItem(contact),
                      ))
                  .toList(),
            ),
    );
  }

  Widget _buildContactItem(Map<String, dynamic> contact) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: (contact['color'] as Color).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            contact['icon'] as IconData,
            size: 16,
            color: contact['color'] as Color,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            contact['value'] as String,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF475569),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }



  Widget _buildTierBadge(DoctorTier? tier) {
    Color tierColor;
    String tierLabel;
    
    switch (tier) {
      case DoctorTier.a:
        tierColor = const Color(0xFF059669);
        tierLabel = 'A';
        break;
      case DoctorTier.b:
        tierColor = const Color(0xFFD97706);
        tierLabel = 'B';
        break;
      case DoctorTier.c:
        tierColor = const Color(0xFFDC2626);
        tierLabel = 'C';
        break;
      default:
        tierColor = const Color(0xFF64748B);
        tierLabel = '?';
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: tierColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          tierLabel,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildVisitHistorySection(Doctor doctor, List<MrVisitLog> visitHistory, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Column(
        children: [
          // Compact header
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.history_rounded,
                  size: 20,
                  color: Color(0xFF2563EB),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Visit History',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      '${visitHistory.length} ${visitHistory.length == 1 ? 'visit' : 'visits'}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showNewVisitModal(doctor),
                icon: const Icon(Icons.add_rounded, size: 16),
                label: const Text('Log Visit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
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
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: visitHistory.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final visit = visitHistory[index];
        return _VisitCard(visit: visit, isTablet: isTablet);
      },
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
}

class _VisitCard extends StatelessWidget {
  final MrVisitLog visit;
  final bool isTablet;

  const _VisitCard({required this.visit, this.isTablet = false});

  @override
  Widget build(BuildContext context) {
    final hasProducts = visit.productsDetailed != null && visit.productsDetailed!.isNotEmpty;
    final hasFeedback = visit.feedbackReceived != null && visit.feedbackReceived!.isNotEmpty;
    final hasNextVisit = visit.nextVisitDate != null;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFBFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Compact date header
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.event_rounded,
                  size: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('MMM dd, yyyy').format(visit.visitDate),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      DateFormat('h:mm a').format(visit.visitDate),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF059669).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Completed',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF059669),
                  ),
                ),
              ),
            ],
          ),
          
          // Compact content sections
          if (hasProducts || hasFeedback) ...[
            const SizedBox(height: 16),
            if (isTablet && hasProducts && hasFeedback)
              Row(
                children: [
                  Expanded(
                    child: _buildCompactInfoSection(
                      'Products',
                      visit.productsDetailed!,
                      Icons.medical_services_rounded,
                      const Color(0xFF7C3AED),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildCompactInfoSection(
                      'Feedback',
                      visit.feedbackReceived!,
                      Icons.feedback_rounded,
                      const Color(0xFF0891B2),
                    ),
                  ),
                ],
              )
            else ...[
              if (hasProducts)
                _buildCompactInfoSection(
                  'Products Discussed',
                  visit.productsDetailed!,
                  Icons.medical_services_rounded,
                  const Color(0xFF7C3AED),
                ),
              if (hasProducts && hasFeedback) const SizedBox(height: 12),
              if (hasFeedback)
                _buildCompactInfoSection(
                  'Doctor Feedback',
                  visit.feedbackReceived!,
                  Icons.feedback_rounded,
                  const Color(0xFF0891B2),
                ),
            ],
          ],
          
          // Next visit info
          if (hasNextVisit) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFD97706).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFD97706).withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD97706).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.schedule_rounded,
                      size: 14,
                      color: Color(0xFFD97706),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Next Follow-up',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFD97706),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          DateFormat('MMM dd, yyyy').format(visit.nextVisitDate!),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ],
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

  Widget _buildCompactInfoSection(String title, String content, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  icon,
                  size: 12,
                  color: color,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF475569),
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
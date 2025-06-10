import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/doctor/doctor_detail_cubit.dart';
import '../bloc/doctor/doctor_state.dart';
import '../models/doctor_models.dart';
import '../widgets/new_visit_log_modal.dart';

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
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Doctor Details',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[700],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<DoctorDetailCubit, DoctorDetailState>(
        builder: (context, state) {
          if (state is DoctorDetailInitial || state is DoctorDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DoctorDetailLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<DoctorDetailCubit>().refreshVisitHistory(widget.doctorId);
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDoctorInfoSection(state.doctor),
                    const SizedBox(height: 24),
                    _buildVisitHistorySection(state.visitHistory),
                  ],
                ),
              ),
            );
          } else if (state is DoctorDetailError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
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


  Widget _buildDoctorInfoSection(Doctor doctor) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildTierBadge(doctor.tier),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.fullName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    if (doctor.specialty != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        doctor.specialty!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildInfoRow(Icons.location_on, 'Clinic Address', doctor.clinicAddress),
          _buildInfoRow(Icons.phone, 'Phone', doctor.phoneNumber),
          _buildInfoRow(Icons.email, 'Email', doctor.email),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTierBadge(DoctorTier? tier) {
    Color tierColor;
    String tierLabel;
    String tierDescription;
    
    switch (tier) {
      case DoctorTier.a:
        tierColor = Colors.green;
        tierLabel = 'A';
        tierDescription = 'High Potential';
        break;
      case DoctorTier.b:
        tierColor = Colors.orange;
        tierLabel = 'B';
        tierDescription = 'Medium Potential';
        break;
      case DoctorTier.c:
        tierColor = Colors.red;
        tierLabel = 'C';
        tierDescription = 'Low Potential';
        break;
      default:
        tierColor = Colors.grey;
        tierLabel = '?';
        tierDescription = 'Unassigned';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: tierColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: tierColor,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: tierColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                tierLabel,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            tierDescription,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: tierColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisitHistorySection(List<MrVisitLog> visitHistory) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Visit History & Actions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _showNewVisitModal(),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Log Visit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (visitHistory.isEmpty)
            _buildEmptyVisitHistory()
          else
            _buildVisitHistoryList(visitHistory),
        ],
      ),
    );
  }

  Widget _buildEmptyVisitHistory() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey[200]!,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.history,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 12),
            Text(
              'No visits recorded yet',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Start by logging your first visit',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisitHistoryList(List<MrVisitLog> visitHistory) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      itemCount: visitHistory.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final visit = visitHistory[index];
        return _VisitCard(visit: visit);
      },
    );
  }


  void _showNewVisitModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => NewVisitLogModal(
        doctorId: widget.doctorId,
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

  const _VisitCard({required this.visit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[200]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: Colors.blue[700],
              ),
              const SizedBox(width: 8),
              Text(
                DateFormat('MMM dd, yyyy').format(visit.visitDate),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[700],
                ),
              ),
              const Spacer(),
              Text(
                DateFormat('HH:mm').format(visit.visitDate),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          if (visit.productsDetailed != null && visit.productsDetailed!.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildInfoSection(
              'Products Discussed',
              visit.productsDetailed!,
              Icons.medical_services,
            ),
          ],
          if (visit.feedbackReceived != null && visit.feedbackReceived!.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildInfoSection(
              'Feedback',
              visit.feedbackReceived!,
              Icons.feedback,
            ),
          ],
          if (visit.nextVisitDate != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.orange[200]!,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 16,
                    color: Colors.orange[700],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Next Follow-up: ${DateFormat('MMM dd, yyyy').format(visit.nextVisitDate!)}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange[700],
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

  Widget _buildInfoSection(String title, String content, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 14,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black87,
            height: 1.3,
          ),
        ),
      ],
    );
  }


}
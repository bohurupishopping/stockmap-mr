// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import '../services/activity_service.dart';
import '../widgets/custom_bottom_navigation.dart';
import '../widgets/loading_overlay.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  List<dynamic> todoVisits = [];
  List<dynamic> completedVisits = [];
  List<dynamic> engagements = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadDailyActivityData();
  }

  Future<void> _loadDailyActivityData() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final data = await ActivityService.getDailyActivityData();
      
      setState(() {
        todoVisits = data['todo_visits'] ?? [];
        completedVisits = data['completed_visits'] ?? [];
        engagements = data['engagements'] ?? [];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load activity data: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageWithBottomNav(
      currentPath: '/dashboard/activity',
      onNewOrderPressed: () => context.go('/dashboard/create'),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          title: const Text(
            'Daily Activity',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xFF1E40AF),
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.white),
              onPressed: _loadDailyActivityData,
            ),
          ],
        ),
        body: isLoading
            ? const LoadingOverlay(isLoading: true, child: SizedBox.shrink())
            : errorMessage != null
                ? _ErrorWidget(message: errorMessage!)
                : RefreshIndicator(
                    onRefresh: _loadDailyActivityData,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _DateHeader(),
                          const SizedBox(height: 24),
                          _TodoSection(
                            todoVisits: todoVisits,
                            engagements: engagements,
                          ),
                          const SizedBox(height: 24),
                          _CompletedSection(completedVisits: completedVisits),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}

class _DateHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final formattedDate = DateFormat('EEEE, MMMM d, yyyy').format(today);
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF1E40AF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Today',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            formattedDate,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _TodoSection extends StatelessWidget {
  final List<dynamic> todoVisits;
  final List<dynamic> engagements;

  const _TodoSection({
    required this.todoVisits,
    required this.engagements,
  });

  @override
  Widget build(BuildContext context) {
    final totalTodos = todoVisits.length + engagements.length;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.schedule,
              color: Color(0xFF059669),
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'To-Do ($totalTodos)',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (totalTodos == 0)
          _EmptyStateCard(
            icon: Icons.check_circle_outline,
            message: 'No planned activities for today',
            color: const Color(0xFF059669),
          )
        else
          Column(
            children: [
              ...todoVisits.map((visit) => _TodoVisitCard(visit: visit)),
              ...engagements.map((engagement) => _EngagementCard(engagement: engagement)),
            ],
          ),
      ],
    );
  }
}

class _CompletedSection extends StatelessWidget {
  final List<dynamic> completedVisits;

  const _CompletedSection({required this.completedVisits});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: Color(0xFF10B981),
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Completed Today (${completedVisits.length})',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (completedVisits.isEmpty)
          _EmptyStateCard(
            icon: Icons.pending_actions,
            message: 'No visits logged yet today',
            color: const Color(0xFF6B7280),
          )
        else
          Column(
            children: completedVisits
                .map((visit) => _CompletedVisitCard(visit: visit))
                .toList(),
          ),
      ],
    );
  }
}

class _TodoVisitCard extends StatelessWidget {
  final dynamic visit;

  const _TodoVisitCard({required this.visit});

  @override
  Widget build(BuildContext context) {
    final doctorName = visit['doctors']['full_name'] ?? 'Unknown Doctor';
    final objective = visit['next_visit_objective'] ?? 'Follow up visit';
    final doctorId = visit['doctor_id'];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => context.go('/dashboard/doctors/$doctorId'),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.calendar_today,
                    color: Color(0xFF3B82F6),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Follow up with $doctorName',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        objective,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF9CA3AF),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EngagementCard extends StatelessWidget {
  final dynamic engagement;

  const _EngagementCard({required this.engagement});

  @override
  Widget build(BuildContext context) {
    final doctorName = engagement['full_name'] ?? 'Unknown Doctor';
    final today = DateTime.now();
    final todayFormatted = '${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
    
    bool isBirthday = false;
    
    if (engagement['date_of_birth'] != null) {
      final dob = DateTime.parse(engagement['date_of_birth']);
      final dobFormatted = '${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}';
      isBirthday = dobFormatted == todayFormatted;
    }
    
    if (!isBirthday && engagement['anniversary_date'] != null) {
      final anniversary = DateTime.parse(engagement['anniversary_date']);
      final anniversaryFormatted = '${anniversary.month.toString().padLeft(2, '0')}-${anniversary.day.toString().padLeft(2, '0')}';
      isBirthday = anniversaryFormatted == todayFormatted; // Using isBirthday for simplicity
    }

    final eventType = isBirthday && engagement['date_of_birth'] != null ? 'Birthday' : 'Anniversary';
    final message = isBirthday && engagement['date_of_birth'] != null
        ? 'Wish $doctorName a Happy Birthday!' 
        : 'Wish $doctorName a Happy Anniversary!';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => context.go('/dashboard/doctors/${engagement['id']}'),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.cake,
                    color: Color(0xFFF59E0B),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        eventType,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF9CA3AF),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CompletedVisitCard extends StatelessWidget {
  final dynamic visit;

  const _CompletedVisitCard({required this.visit});

  @override
  Widget build(BuildContext context) {
    final doctorName = visit['doctors']['full_name'] ?? 'Unknown Doctor';
    final visitTime = DateTime.parse(visit['visit_date']);
    final timeFormatted = DateFormat('h:mm a').format(visitTime);
    
    String productsSummary = 'No products detailed';
    if (visit['products_detailed'] != null && visit['products_detailed'].isNotEmpty) {
      try {
        final products = jsonDecode(visit['products_detailed']) as List;
        if (products.isNotEmpty) {
          productsSummary = '${products.length} product(s) discussed';
        }
      } catch (e) {
        productsSummary = 'Products discussed';
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Color(0xFF10B981),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Visit logged for $doctorName',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$productsSummary • $timeFormatted',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyStateCard extends StatelessWidget {
  final IconData icon;
  final String message;
  final Color color;

  const _EmptyStateCard({
    required this.icon,
    required this.message,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 48,
            color: color.withValues(alpha: 0.6),
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: color.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String message;

  const _ErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Color(0xFFEF4444),
            ),
            const SizedBox(height: 16),
            SelectableText.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Error: ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFEF4444),
                    ),
                  ),
                  TextSpan(
                    text: message,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/speedometer/speedometer_cubit.dart';
import '../bloc/speedometer/speedometer_state.dart';
import '../models/target_models.dart';
import '../widgets/speedometer/speedometer_gauge.dart';
import '../widgets/speedometer/metric_cards.dart';
import '../widgets/speedometer/target_form_modal.dart';
import '../widgets/speedometer/focus_goal_card.dart';
import '../widgets/speedometer/sales_details_list.dart';
import '../widgets/loading_overlay.dart';
import '../widgets/custom_bottom_navigation.dart';

class SpeedometerPage extends StatefulWidget {
  const SpeedometerPage({super.key});

  @override
  State<SpeedometerPage> createState() => _SpeedometerPageState();
}

class _SpeedometerPageState extends State<SpeedometerPage> {
  @override
  void initState() {
    super.initState();
    // Load initial data
    context.read<SpeedometerCubit>().loadDashboardData('This Month');
  }

  @override
  Widget build(BuildContext context) {
    return PageWithBottomNav(
      currentPath: '/dashboard/speedometer',
      onNewOrderPressed: () => context.go('/dashboard/create'),
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: BlocConsumer<SpeedometerCubit, SpeedometerState>(
            listener: (context, state) {
              if (state is SpeedometerError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () => context
                        .read<SpeedometerCubit>()
                        .loadDashboardData(state.selectedPeriod),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildHeader(context, state),
                          _buildContent(context, state),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  if (state is SpeedometerLoading || state is SpeedometerCreatingTarget)
                    LoadingOverlay(
                      isLoading: true,
                      child: Container(),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, SpeedometerState state) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6366f1),
            Color(0xFF8b5cf6),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              // Icon and title
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.speed_rounded,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sales Performance',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Track your goals & achievements',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
              // Period selector
              BlocBuilder<SpeedometerCubit, SpeedometerState>(
                builder: (context, state) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.calendar_month,
                        color: Colors.white,
                        size: 24,
                      ),
                      onSelected: (period) {
                        context.read<SpeedometerCubit>().changePeriod(period);
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'This Month',
                          child: Row(
                            children: [
                              Icon(
                                state.selectedPeriod == 'This Month'
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_unchecked,
                                size: 20,
                                color: const Color(0xFF6366f1),
                              ),
                              const SizedBox(width: 8),
                              const Text('This Month'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'Last Month',
                          child: Row(
                            children: [
                              Icon(
                                state.selectedPeriod == 'Last Month'
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_unchecked,
                                size: 20,
                                color: const Color(0xFF6366f1),
                              ),
                              const SizedBox(width: 8),
                              const Text('Last Month'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'This Quarter',
                          child: Row(
                            children: [
                              Icon(
                                state.selectedPeriod == 'This Quarter'
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_unchecked,
                                size: 20,
                                color: const Color(0xFF6366f1),
                              ),
                              const SizedBox(width: 8),
                              const Text('This Quarter'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
              // Refresh button
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () => context
                      .read<SpeedometerCubit>()
                      .loadDashboardData(state.selectedPeriod),
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, SpeedometerState state) {
    if (state is SpeedometerInitial) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state is SpeedometerLoading) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state is SpeedometerLoaded) {
      return _buildDashboard(context, state.dashboardData, state.selectedPeriod);
    } else if (state is SpeedometerCreatingTarget) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state is SpeedometerError) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 80,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 16),
              Text(
                'Error loading dashboard',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                state.message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context
                    .read<SpeedometerCubit>()
                    .loadDashboardData(state.selectedPeriod),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366f1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }
    
    // Fallback for unknown state
    return const Padding(
      padding: EdgeInsets.all(32),
      child: Center(
        child: Text('Unknown state'),
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, DashboardData data, String period) {
    // Check if target exists
    if (data.target == null) {
      return _buildNoTargetView(context, period);
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Period indicator with modern styling
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6366f1).withValues(alpha: 0.1),
                  const Color(0xFF8b5cf6).withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF6366f1).withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: const Color(0xFF6366f1),
                ),
                const SizedBox(width: 8),
                Text(
                  period,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6366f1),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Speedometer Gauge
          SpeedometerGauge(
            data: data,
            cubit: context.read<SpeedometerCubit>(),
          ),
          const SizedBox(height: 24),
          
          // Metric Cards
          MetricCards(
            data: data,
            cubit: context.read<SpeedometerCubit>(),
          ),
          const SizedBox(height: 16),
          
          // Focus Goal Card (if exists)
          if (data.focusGoalProgress != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: FocusGoalCard(
                progress: data.focusGoalProgress!,
              ),
            ),

          // Sales Details List
          SalesDetailsList(
            sales: data.recentSales,
          ),
        ],
      ),
    );
  }

  Widget _buildNoTargetView(BuildContext context, String period) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF6366f1).withValues(alpha: 0.1),
                    const Color(0xFF8b5cf6).withValues(alpha: 0.1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.track_changes,
                size: 80,
                color: Color(0xFF6366f1),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Set Your Goal for $period!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1e293b),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Start tracking your sales performance by setting a target for this period.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF6366f1),
                    Color(0xFF8b5cf6),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6366f1).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: () => _showTargetForm(context, period),
                icon: const Icon(Icons.add_task, color: Colors.white),
                label: const Text(
                  'Set My Goal',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTargetForm(BuildContext context, String period) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: context.read<SpeedometerCubit>(),
        child: TargetFormModal(period: period),
      ),
    );
  }
}
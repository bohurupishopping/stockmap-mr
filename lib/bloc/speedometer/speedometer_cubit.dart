import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/target_models.dart';
import '../../services/target_service.dart';
import 'speedometer_state.dart';

class SpeedometerCubit extends Cubit<SpeedometerState> {
  SpeedometerCubit() : super(const SpeedometerState.initial());

  /// Load dashboard data for the specified period
  Future<void> loadDashboardData(String period) async {
    try {
      log('SpeedometerCubit: Loading dashboard data for period: $period');
      emit(SpeedometerState.loading(selectedPeriod: period));
      
      final dashboardData = await TargetService.getDashboardData(period);
      
      emit(SpeedometerState.loaded(
        selectedPeriod: period,
        dashboardData: dashboardData,
      ));
      
      log('SpeedometerCubit: Dashboard data loaded successfully');
    } catch (e) {
      log('SpeedometerCubit: Error loading dashboard data: $e');
      emit(SpeedometerState.error(
        selectedPeriod: period,
        message: e.toString(),
      ));
    }
  }

  /// Create a new target
  Future<void> createTarget(TargetFormData formData, String period) async {
    try {
      log('SpeedometerCubit: Creating target for period: $period');
      emit(SpeedometerState.creatingTarget(selectedPeriod: period));
      
      await TargetService.createTarget(formData, period);
      
      // Reload dashboard data after creating target
      await loadDashboardData(period);
      
      log('SpeedometerCubit: Target created successfully');
    } catch (e) {
      log('SpeedometerCubit: Error creating target: $e');
      emit(SpeedometerState.error(
        selectedPeriod: period,
        message: 'Failed to create target: ${e.toString()}',
      ));
    }
  }

  /// Change the selected period and reload data
  Future<void> changePeriod(String newPeriod) async {
    if (state.selectedPeriod != newPeriod) {
      await loadDashboardData(newPeriod);
    }
  }

  /// Get available products for focus goals
  Future<List<Map<String, dynamic>>> getAvailableProducts() async {
    try {
      return await TargetService.getAvailableProducts();
    } catch (e) {
      log('SpeedometerCubit: Error getting available products: $e');
      return [];
    }
  }

  /// Calculate progress percentage
  double getProgressPercentage(DashboardData data) {
    if (data.target == null || data.target!.targetSalesAmount == 0) {
      return 0.0;
    }
    return (data.totalSalesAmount / data.target!.targetSalesAmount * 100).clamp(0.0, 100.0);
  }

  /// Calculate collection rate percentage
  double getCollectionRate(DashboardData data) {
    if (data.totalSalesAmount == 0) {
      return 0.0;
    }
    return (data.totalCollectedAmount / data.totalSalesAmount * 100).clamp(0.0, 100.0);
  }

  /// Get tier status based on current sales
  String getTierStatus(DashboardData data) {
    if (data.target == null) return 'No Target';
    
    final target = data.target!;
    final currentSales = data.totalSalesAmount;
    
    if (target.targetTierGold != null && currentSales >= target.targetTierGold!) {
      return 'Gold';
    } else if (currentSales >= target.targetSalesAmount) {
      return 'Silver';
    } else if (target.targetTierBronze != null && currentSales >= target.targetTierBronze!) {
      return 'Bronze';
    } else {
      return 'In Progress';
    }
  }

  /// Get tier color based on current status
  String getTierColor(String tierStatus) {
    switch (tierStatus) {
      case 'Gold':
        return '#FFD700';
      case 'Silver':
        return '#C0C0C0';
      case 'Bronze':
        return '#CD7F32';
      default:
        return '#2196F3';
    }
  }
}
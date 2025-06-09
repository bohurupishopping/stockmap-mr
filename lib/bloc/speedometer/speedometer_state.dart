import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/target_models.dart';

part 'speedometer_state.freezed.dart';

@freezed
abstract class SpeedometerState with _$SpeedometerState {
  const SpeedometerState._();
  
  const factory SpeedometerState.initial({
    @Default('This Month') String selectedPeriod,
  }) = SpeedometerInitial;
  
  const factory SpeedometerState.loading({
    required String selectedPeriod,
  }) = SpeedometerLoading;
  
  const factory SpeedometerState.loaded({
    required String selectedPeriod,
    required DashboardData dashboardData,
  }) = SpeedometerLoaded;
  
  const factory SpeedometerState.creatingTarget({
    required String selectedPeriod,
  }) = SpeedometerCreatingTarget;
  
  const factory SpeedometerState.error({
    required String selectedPeriod,
    required String message,
  }) = SpeedometerError;
}
import 'package:freezed_annotation/freezed_annotation.dart';
import 'order_models.dart';

part 'target_models.freezed.dart';
part 'target_models.g.dart';

enum TargetPeriodType {
  @JsonValue('Monthly')
  monthly,
  @JsonValue('Quarterly')
  quarterly,
  @JsonValue('Yearly')
  yearly,
}

@freezed
abstract class MrSalesTarget with _$MrSalesTarget {
  const MrSalesTarget._();
  
  const factory MrSalesTarget({
    required String id,
    @JsonKey(name: 'mr_user_id') required String mrUserId,
    @JsonKey(name: 'period_type') required TargetPeriodType periodType,
    @JsonKey(name: 'start_date') required DateTime startDate,
    @JsonKey(name: 'end_date') required DateTime endDate,
    @JsonKey(name: 'target_sales_amount') required double targetSalesAmount,
    @JsonKey(name: 'target_tier_bronze') double? targetTierBronze,
    @JsonKey(name: 'target_tier_gold') double? targetTierGold,
    @JsonKey(name: 'product_specific_goals') Map<String, dynamic>? productSpecificGoals,
    @JsonKey(name: 'target_collection_percentage') double? targetCollectionPercentage,
    @JsonKey(name: 'is_locked') @Default(false) bool isLocked,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _MrSalesTarget;

  factory MrSalesTarget.fromJson(Map<String, dynamic> json) =>
      _$MrSalesTargetFromJson(json);
}

@freezed
abstract class ProductSpecificGoal with _$ProductSpecificGoal {
  const ProductSpecificGoal._();
  
  const factory ProductSpecificGoal({
    required String type, // 'product' or 'category'
    required String id,
    int? goalUnits,
    double? goalAmount,
  }) = _ProductSpecificGoal;

  factory ProductSpecificGoal.fromJson(Map<String, dynamic> json) =>
      _$ProductSpecificGoalFromJson(json);
}

@freezed
abstract class DashboardData with _$DashboardData {
  const DashboardData._();
  
  const factory DashboardData({
    MrSalesTarget? target,
    required double totalSalesAmount,
    required double totalCollectedAmount,
    required List<MrSalesOrder> recentSales,
    ProductGoalProgress? focusGoalProgress,
  }) = _DashboardData;

  factory DashboardData.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataFromJson(json);
}

@freezed
abstract class ProductGoalProgress with _$ProductGoalProgress {
  const ProductGoalProgress._();
  
  const factory ProductGoalProgress({
    required String productName,
    required int currentUnits,
    required int targetUnits,
    double? currentAmount,
    double? targetAmount,
  }) = _ProductGoalProgress;

  factory ProductGoalProgress.fromJson(Map<String, dynamic> json) =>
      _$ProductGoalProgressFromJson(json);
}

@freezed
abstract class TargetFormData with _$TargetFormData {
  const TargetFormData._();
  
  const factory TargetFormData({
    @Default(0.0) double mainGoal,
    @Default(0.0) double bronzeGoal,
    @Default(0.0) double goldGoal,
    @Default(0.0) double collectionPercentage,
    String? focusProductId,
    String? focusProductName,
    @Default(0) int focusGoalUnits,
    @Default(0.0) double focusGoalAmount,
    @Default('product') String focusType,
  }) = _TargetFormData;

  factory TargetFormData.fromJson(Map<String, dynamic> json) =>
      _$TargetFormDataFromJson(json);
}
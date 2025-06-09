// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'target_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MrSalesTarget _$MrSalesTargetFromJson(Map<String, dynamic> json) =>
    _MrSalesTarget(
      id: json['id'] as String,
      mrUserId: json['mr_user_id'] as String,
      periodType: $enumDecode(_$TargetPeriodTypeEnumMap, json['period_type']),
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      targetSalesAmount: (json['target_sales_amount'] as num).toDouble(),
      targetTierBronze: (json['target_tier_bronze'] as num?)?.toDouble(),
      targetTierGold: (json['target_tier_gold'] as num?)?.toDouble(),
      productSpecificGoals:
          json['product_specific_goals'] as Map<String, dynamic>?,
      targetCollectionPercentage: (json['target_collection_percentage'] as num?)
          ?.toDouble(),
      isLocked: json['is_locked'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$MrSalesTargetToJson(_MrSalesTarget instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mr_user_id': instance.mrUserId,
      'period_type': _$TargetPeriodTypeEnumMap[instance.periodType]!,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'target_sales_amount': instance.targetSalesAmount,
      'target_tier_bronze': instance.targetTierBronze,
      'target_tier_gold': instance.targetTierGold,
      'product_specific_goals': instance.productSpecificGoals,
      'target_collection_percentage': instance.targetCollectionPercentage,
      'is_locked': instance.isLocked,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$TargetPeriodTypeEnumMap = {
  TargetPeriodType.monthly: 'Monthly',
  TargetPeriodType.quarterly: 'Quarterly',
  TargetPeriodType.yearly: 'Yearly',
};

_ProductSpecificGoal _$ProductSpecificGoalFromJson(Map<String, dynamic> json) =>
    _ProductSpecificGoal(
      type: json['type'] as String,
      id: json['id'] as String,
      goalUnits: (json['goalUnits'] as num?)?.toInt(),
      goalAmount: (json['goalAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProductSpecificGoalToJson(
  _ProductSpecificGoal instance,
) => <String, dynamic>{
  'type': instance.type,
  'id': instance.id,
  'goalUnits': instance.goalUnits,
  'goalAmount': instance.goalAmount,
};

_DashboardData _$DashboardDataFromJson(Map<String, dynamic> json) =>
    _DashboardData(
      target: json['target'] == null
          ? null
          : MrSalesTarget.fromJson(json['target'] as Map<String, dynamic>),
      totalSalesAmount: (json['totalSalesAmount'] as num).toDouble(),
      totalCollectedAmount: (json['totalCollectedAmount'] as num).toDouble(),
      recentSales: (json['recentSales'] as List<dynamic>)
          .map((e) => MrSalesOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
      focusGoalProgress: json['focusGoalProgress'] == null
          ? null
          : ProductGoalProgress.fromJson(
              json['focusGoalProgress'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$DashboardDataToJson(_DashboardData instance) =>
    <String, dynamic>{
      'target': instance.target,
      'totalSalesAmount': instance.totalSalesAmount,
      'totalCollectedAmount': instance.totalCollectedAmount,
      'recentSales': instance.recentSales,
      'focusGoalProgress': instance.focusGoalProgress,
    };

_ProductGoalProgress _$ProductGoalProgressFromJson(Map<String, dynamic> json) =>
    _ProductGoalProgress(
      productName: json['productName'] as String,
      currentUnits: (json['currentUnits'] as num).toInt(),
      targetUnits: (json['targetUnits'] as num).toInt(),
      currentAmount: (json['currentAmount'] as num?)?.toDouble(),
      targetAmount: (json['targetAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProductGoalProgressToJson(
  _ProductGoalProgress instance,
) => <String, dynamic>{
  'productName': instance.productName,
  'currentUnits': instance.currentUnits,
  'targetUnits': instance.targetUnits,
  'currentAmount': instance.currentAmount,
  'targetAmount': instance.targetAmount,
};

_TargetFormData _$TargetFormDataFromJson(Map<String, dynamic> json) =>
    _TargetFormData(
      mainGoal: (json['mainGoal'] as num?)?.toDouble() ?? 0.0,
      bronzeGoal: (json['bronzeGoal'] as num?)?.toDouble() ?? 0.0,
      goldGoal: (json['goldGoal'] as num?)?.toDouble() ?? 0.0,
      collectionPercentage:
          (json['collectionPercentage'] as num?)?.toDouble() ?? 0.0,
      focusProductId: json['focusProductId'] as String?,
      focusProductName: json['focusProductName'] as String?,
      focusGoalUnits: (json['focusGoalUnits'] as num?)?.toInt() ?? 0,
      focusGoalAmount: (json['focusGoalAmount'] as num?)?.toDouble() ?? 0.0,
      focusType: json['focusType'] as String? ?? 'product',
    );

Map<String, dynamic> _$TargetFormDataToJson(_TargetFormData instance) =>
    <String, dynamic>{
      'mainGoal': instance.mainGoal,
      'bronzeGoal': instance.bronzeGoal,
      'goldGoal': instance.goldGoal,
      'collectionPercentage': instance.collectionPercentage,
      'focusProductId': instance.focusProductId,
      'focusProductName': instance.focusProductName,
      'focusGoalUnits': instance.focusGoalUnits,
      'focusGoalAmount': instance.focusGoalAmount,
      'focusType': instance.focusType,
    };

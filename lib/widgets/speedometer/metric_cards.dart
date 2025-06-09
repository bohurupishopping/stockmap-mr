// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:flutter/material.dart';
import '../../models/target_models.dart';
import '../../bloc/speedometer/speedometer_cubit.dart';

class MetricCards extends StatelessWidget {
  final DashboardData data;
  final SpeedometerCubit cubit;

  const MetricCards({
    super.key,
    required this.data,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First row: Target and Achieved
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                context,
                'Sales Target',
                data.target?.targetSalesAmount ?? 0.0,
                Icons.flag_outlined,
                const Color(0xFF6366F1), // Indigo
                isAmount: true,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildMetricCard(
                context,
                'Sales Achieved',
                data.totalSalesAmount,
                Icons.trending_up_rounded,
                const Color(0xFF10B981), // Emerald
                isAmount: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        
        // Second row: Collection Rate and Remaining
        Row(
          children: [
            Expanded(
              child: _buildCollectionCard(context),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildRemainingCard(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    BuildContext context,
    String title,
    double value,
    IconData icon,
    Color color, {
    bool isAmount = false,
    String? subtitle,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark 
            ? const Color(0xFF1F2937) 
            : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark 
              ? const Color(0xFF374151) 
              : const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: isDark 
                        ? const Color(0xFF9CA3AF) 
                        : const Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            isAmount ? '₹${_formatAmount(value)}' : value.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: -0.5,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10,
                color: isDark 
                    ? const Color(0xFF6B7280) 
                    : const Color(0xFF94A3B8),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCollectionCard(BuildContext context) {
    final collectionRate = cubit.getCollectionRate(data);
    final targetRate = data.target?.targetCollectionPercentage ?? 100.0;
    final isOnTarget = collectionRate >= targetRate;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final cardColor = isOnTarget 
        ? const Color(0xFF10B981) // Emerald
        : const Color(0xFFF59E0B); // Amber
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark 
            ? const Color(0xFF1F2937) 
            : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark 
              ? const Color(0xFF374151) 
              : const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: cardColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  color: cardColor,
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Collection Rate',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: isDark 
                        ? const Color(0xFF9CA3AF) 
                        : const Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '${collectionRate.toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: cardColor,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                isOnTarget 
                    ? Icons.trending_up_rounded 
                    : Icons.trending_down_rounded,
                color: cardColor,
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            'Target: ${targetRate.toStringAsFixed(0)}%',
            style: TextStyle(
              fontSize: 10,
              color: isDark 
                  ? const Color(0xFF6B7280) 
                  : const Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (collectionRate / 100).clamp(0.0, 1.0),
              backgroundColor: isDark 
                  ? const Color(0xFF374151) 
                  : const Color(0xFFE2E8F0),
              valueColor: AlwaysStoppedAnimation(cardColor),
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRemainingCard(BuildContext context) {
    final target = data.target?.targetSalesAmount ?? 0.0;
    final achieved = data.totalSalesAmount;
    final remaining = (target - achieved).clamp(0.0, double.infinity);
    final isCompleted = achieved >= target;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final cardColor = isCompleted 
        ? const Color(0xFF10B981) // Emerald
        : const Color(0xFF3B82F6); // Blue
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark 
            ? const Color(0xFF1F2937) 
            : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark 
              ? const Color(0xFF374151) 
              : const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: cardColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  isCompleted 
                      ? Icons.check_circle_outline_rounded 
                      : Icons.flag_outlined,
                  color: cardColor,
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isCompleted ? 'Target Achieved!' : 'Remaining',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: isDark 
                        ? const Color(0xFF9CA3AF) 
                        : const Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            isCompleted ? '🎉 Excellent!' : '₹${_formatAmount(remaining)}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: cardColor,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            isCompleted 
                ? 'Exceeded by ₹${_formatAmount(achieved - target)}'
                : 'to reach target',
            style: TextStyle(
              fontSize: 10,
              color: isDark 
                  ? const Color(0xFF6B7280) 
                  : const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  String _formatAmount(double amount) {
    if (amount >= 10000000) {
      return '${(amount / 10000000).toStringAsFixed(1)}Cr';
    } else if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(1)}L';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return amount.toStringAsFixed(0);
    }
  }
}
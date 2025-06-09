// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../models/target_models.dart';
import '../../bloc/speedometer/speedometer_cubit.dart';

class SpeedometerGauge extends StatelessWidget {
  final DashboardData data;
  final SpeedometerCubit cubit;

  const SpeedometerGauge({
    super.key,
    required this.data,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    final progress = cubit.getProgressPercentage(data);
    final tierStatus = cubit.getTierStatus(data);
    final tierColor = Color(int.parse(cubit.getTierColor(tierStatus).replaceFirst('#', '0xFF')));
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Gauge
          SizedBox(
            width: 200,
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background gauge
                CustomPaint(
                  size: const Size(200, 200),
                  painter: GaugeBackgroundPainter(
                    bronzeThreshold: _getBronzePercentage(),
                    silverThreshold: 100.0,
                    goldThreshold: _getGoldPercentage(),
                  ),
                ),
                // Progress gauge
                CustomPaint(
                  size: const Size(200, 200),
                  painter: GaugeProgressPainter(
                    progress: progress,
                    color: tierColor,
                  ),
                ),
                // Center content
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${progress.toStringAsFixed(1)}%',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: tierColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: tierColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        tierStatus,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: tierColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // Tier indicators
          if (data.target != null) _buildTierIndicators(context),
        ],
      ),
    );
  }

  Widget _buildTierIndicators(BuildContext context) {
    final target = data.target!;
    final currentSales = data.totalSalesAmount;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (target.targetTierBronze != null)
          _buildTierIndicator(
            context,
            'Bronze',
            target.targetTierBronze!,
            currentSales >= target.targetTierBronze!,
            const Color(0xFFCD7F32),
          ),
        _buildTierIndicator(
          context,
          'Silver',
          target.targetSalesAmount,
          currentSales >= target.targetSalesAmount,
          const Color(0xFFC0C0C0),
        ),
        if (target.targetTierGold != null)
          _buildTierIndicator(
            context,
            'Gold',
            target.targetTierGold!,
            currentSales >= target.targetTierGold!,
            const Color(0xFFFFD700),
          ),
      ],
    );
  }

  Widget _buildTierIndicator(
    BuildContext context,
    String tier,
    double amount,
    bool achieved,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: achieved ? color : color.withOpacity(0.3),
            shape: BoxShape.circle,
            border: Border.all(
              color: color,
              width: 2,
            ),
          ),
          child: Icon(
            achieved ? Icons.check : Icons.lock_outline,
            color: achieved ? Colors.white : color,
            size: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          tier,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: achieved ? color : color.withOpacity(0.7),
          ),
        ),
        Text(
          '₹${_formatAmount(amount)}',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  double _getBronzePercentage() {
    if (data.target?.targetTierBronze == null || data.target?.targetSalesAmount == 0) {
      return 0.0;
    }
    return (data.target!.targetTierBronze! / data.target!.targetSalesAmount * 100).clamp(0.0, 100.0);
  }

  double _getGoldPercentage() {
    if (data.target?.targetTierGold == null || data.target?.targetSalesAmount == 0) {
      return 100.0;
    }
    return (data.target!.targetTierGold! / data.target!.targetSalesAmount * 100).clamp(100.0, 200.0);
  }

  String _formatAmount(double amount) {
    if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(1)}L';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return amount.toStringAsFixed(0);
    }
  }
}

class GaugeBackgroundPainter extends CustomPainter {
  final double bronzeThreshold;
  final double silverThreshold;
  final double goldThreshold;

  GaugeBackgroundPainter({
    required this.bronzeThreshold,
    required this.silverThreshold,
    required this.goldThreshold,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 20;
    const strokeWidth = 12.0;
    const startAngle = -math.pi * 0.75; // Start from top-left
    const sweepAngle = math.pi * 1.5; // 270 degrees

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Background arc
    paint.color = Colors.grey.withOpacity(0.2);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );

    // Bronze zone
    if (bronzeThreshold > 0) {
      paint.color = const Color(0xFFCD7F32).withOpacity(0.3);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle * (bronzeThreshold / 100),
        false,
        paint,
      );
    }

    // Silver zone
    paint.color = const Color(0xFFC0C0C0).withOpacity(0.3);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle + sweepAngle * (bronzeThreshold / 100),
      sweepAngle * ((silverThreshold - bronzeThreshold) / 100),
      false,
      paint,
    );

    // Gold zone (if exists and extends beyond 100%)
    if (goldThreshold > 100) {
      paint.color = const Color(0xFFFFD700).withOpacity(0.3);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle + sweepAngle,
        sweepAngle * ((goldThreshold - 100) / 100) * 0.5, // Half arc for gold extension
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class GaugeProgressPainter extends CustomPainter {
  final double progress;
  final Color color;

  GaugeProgressPainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 20;
    const strokeWidth = 12.0;
    const startAngle = -math.pi * 0.75;
    const maxSweepAngle = math.pi * 1.5;
    final sweepAngle = maxSweepAngle * (progress / 100).clamp(0.0, 1.0);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
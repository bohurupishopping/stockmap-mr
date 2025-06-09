// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../models/target_models.dart';
import '../../bloc/speedometer/speedometer_cubit.dart';

class SpeedometerGauge extends StatefulWidget {
  final DashboardData data;
  final SpeedometerCubit cubit;

  const SpeedometerGauge({
    super.key,
    required this.data,
    required this.cubit,
  });

  @override
  State<SpeedometerGauge> createState() => _SpeedometerGaugeState();
}

class _SpeedometerGaugeState extends State<SpeedometerGauge>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _pulseController;
  late Animation<double> _progressAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _progressAnimation = CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeOutCubic,
    );
    _pulseAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _progressController.forward();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _progressController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = widget.cubit.getProgressPercentage(widget.data);
    final tierStatus = widget.cubit.getTierStatus(widget.data);
    final tierColor = _getTierColor(tierStatus);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1B23) : const Color(0xFFFAFBFC),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? const Color(0xFF2A2B35) : const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Modern Gauge
          AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return SizedBox(
                width: 220,
                height: 220,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background gauge
                    CustomPaint(
                      size: const Size(220, 220),
                      painter: ModernGaugeBackgroundPainter(
                        bronzeThreshold: _getBronzePercentage(),
                        silverThreshold: 100.0,
                        goldThreshold: _getGoldPercentage(),
                        isDark: isDark,
                      ),
                    ),
                    // Progress gauge with animation
                    CustomPaint(
                      size: const Size(220, 220),
                      painter: ModernGaugeProgressPainter(
                        progress: progress * _progressAnimation.value,
                        color: tierColor,
                        isDark: isDark,
                      ),
                    ),
                    // Center content with pulse animation
                    AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: progress > 90 ? _pulseAnimation.value : 1.0,
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF2A2B35) : Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: tierColor.withOpacity(0.2),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 300),
                                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: tierColor,
                                    fontSize: 32,
                                  ) ?? const TextStyle(),
                                  child: Text(
                                    '${(progress * _progressAnimation.value).toStringAsFixed(1)}%',
                                  ),
                                ),
                                const SizedBox(height: 8),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        tierColor.withOpacity(0.1),
                                        tierColor.withOpacity(0.2),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: tierColor.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    tierStatus,
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      color: tierColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          
          // Modern Tier indicators
          if (widget.data.target != null) _buildModernTierIndicators(context),
        ],
      ),
    );
  }

  Widget _buildModernTierIndicators(BuildContext context) {
    final target = widget.data.target!;
    final currentSales = widget.data.totalSalesAmount;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF242530) : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? const Color(0xFF2A2B35) : const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (target.targetTierBronze != null)
            _buildModernTierIndicator(
              context,
              'Bronze',
              target.targetTierBronze!,
              currentSales >= target.targetTierBronze!,
              const Color(0xFFD97706),
              Icons.military_tech,
            ),
          _buildModernTierIndicator(
            context,
            'Silver',
            target.targetSalesAmount,
            currentSales >= target.targetSalesAmount,
            const Color(0xFF6B7280),
            Icons.workspace_premium,
          ),
          if (target.targetTierGold != null)
            _buildModernTierIndicator(
              context,
              'Gold',
              target.targetTierGold!,
              currentSales >= target.targetTierGold!,
              const Color(0xFFF59E0B),
              Icons.diamond,
            ),
        ],
      ),
    );
  }

  Widget _buildModernTierIndicator(
    BuildContext context,
    String tier,
    double amount,
    bool achieved,
    Color color,
    IconData icon,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 800 + (tier.hashCode % 400)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Opacity(
            opacity: value,
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: achieved
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              color,
                              color.withOpacity(0.8),
                            ],
                          )
                        : null,
                    color: achieved ? null : (isDark ? const Color(0xFF374151) : const Color(0xFFF3F4F6)),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: achieved ? color.withOpacity(0.3) : (isDark ? const Color(0xFF4B5563) : const Color(0xFFD1D5DB)),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    achieved ? Icons.check_circle : icon,
                    color: achieved ? Colors.white : color.withOpacity(0.6),
                    size: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  tier,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: achieved ? color : (isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280)),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '₹${_formatAmount(amount)}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getTierColor(String tierStatus) {
    switch (tierStatus.toLowerCase()) {
      case 'bronze':
        return const Color(0xFFD97706);
      case 'silver':
        return const Color(0xFF6B7280);
      case 'gold':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF3B82F6); // Blue for default/progress
    }
  }

  double _getBronzePercentage() {
    if (widget.data.target?.targetTierBronze == null || widget.data.target?.targetSalesAmount == 0) {
      return 0.0;
    }
    return (widget.data.target!.targetTierBronze! / widget.data.target!.targetSalesAmount * 100).clamp(0.0, 100.0);
  }

  double _getGoldPercentage() {
    if (widget.data.target?.targetTierGold == null || widget.data.target?.targetSalesAmount == 0) {
      return 100.0;
    }
    return (widget.data.target!.targetTierGold! / widget.data.target!.targetSalesAmount * 100).clamp(100.0, 200.0);
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

class ModernGaugeBackgroundPainter extends CustomPainter {
  final double bronzeThreshold;
  final double silverThreshold;
  final double goldThreshold;
  final bool isDark;

  ModernGaugeBackgroundPainter({
    required this.bronzeThreshold,
    required this.silverThreshold,
    required this.goldThreshold,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 25;
    const strokeWidth = 8.0;
    const startAngle = -math.pi * 0.75;
    const sweepAngle = math.pi * 1.5;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Background arc
    paint.color = isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );

    // Bronze zone
    if (bronzeThreshold > 0) {
      paint.color = const Color(0xFFD97706).withOpacity(0.2);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle * (bronzeThreshold / 100),
        false,
        paint,
      );
    }

    // Silver zone
    paint.color = const Color(0xFF6B7280).withOpacity(0.2);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle + sweepAngle * (bronzeThreshold / 100),
      sweepAngle * ((silverThreshold - bronzeThreshold) / 100),
      false,
      paint,
    );

    // Gold zone
    if (goldThreshold > 100) {
      paint.color = const Color(0xFFF59E0B).withOpacity(0.2);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle + sweepAngle,
        sweepAngle * ((goldThreshold - 100) / 100) * 0.5,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ModernGaugeProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final bool isDark;

  ModernGaugeProgressPainter({
    required this.progress,
    required this.color,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 25;
    const strokeWidth = 8.0;
    const startAngle = -math.pi * 0.75;
    const maxSweepAngle = math.pi * 1.5;
    final sweepAngle = maxSweepAngle * (progress / 100).clamp(0.0, 1.0);

    // Create gradient effect
    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradient = SweepGradient(
      startAngle: startAngle,
      endAngle: startAngle + sweepAngle,
      colors: [
        color.withOpacity(0.8),
        color,
        color.withOpacity(0.9),
      ],
      stops: const [0.0, 0.5, 1.0],
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      rect,
      startAngle,
      sweepAngle,
      false,
      paint,
    );

    // Add glow effect for high progress
    if (progress > 80) {
      final glowPaint = Paint()
        ..color = color.withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth + 4
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

      canvas.drawArc(
        rect,
        startAngle,
        sweepAngle,
        false,
        glowPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
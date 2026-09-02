import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';

enum LoadingType { circularDots, waveBars }

class CustomLoading extends StatefulWidget {
  final LoadingType type;
  final double size;
  final Color color;
  final Color? secondaryColor;
  final Duration duration;

  const CustomLoading({
    super.key,
    this.type = LoadingType.circularDots,
    this.size = 50.0,
    this.color = AppColors.primary,
    this.secondaryColor = AppColors.secondary,
    this.duration = const Duration(milliseconds: 1200),
  });

  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CustomPaint(
        painter: widget.type == LoadingType.circularDots
            ? _CircularDotsPainter(animation: _controller, color: widget.color)
            : _WaveBarsPainter(
                animation: _controller,
                primaryColor: widget.color,
                secondaryColor: widget.secondaryColor ?? widget.color,
              ),
      ),
    );
  }
}

// =========================================================================
// 1. CIRCULAR DOTS PAINTER (Trigonometric Orbit & Scale Tapering)
// =========================================================================
class _CircularDotsPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;
  static const int dotCount = 8;

  _CircularDotsPainter({required this.animation, required this.color})
    : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final double center = size.width / 2;
    final double orbitRadius = size.width * 0.35;
    final double maxDotRadius = size.width * 0.12;
    final double minDotRadius = size.width * 0.03;

    final Paint paint = Paint()..style = PaintingStyle.fill;

    // Angular velocity phase (full 2π rotation per animation cycle)
    final double currentAngleOffset = animation.value * 2 * math.pi;

    for (int i = 0; i < dotCount; i++) {
      // Polar angle for dot 'i': θ = 2π * (i / N) + animationPhase
      final double theta = (2 * math.pi * (i / dotCount)) + currentAngleOffset;

      // Cartesian transformation: x = r * cos(θ), y = r * sin(θ)
      final double x = center + orbitRadius * math.cos(theta);
      final double y = center + orbitRadius * math.sin(theta);

      // Linear interpolation scale based on position index [0.0 to 1.0]
      final double scaleProgress = i / dotCount;
      final double dotRadius =
          minDotRadius + (maxDotRadius - minDotRadius) * scaleProgress;

      // Alpha gradient taper along the tail
      final double alpha = 0.3 + (0.7 * scaleProgress);
      paint.color = color.withValues(alpha: alpha);

      canvas.drawCircle(Offset(x, y), dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CircularDotsPainter oldDelegate) => false;
}

// =========================================================================
// 2. WAVE BARS PAINTER (Phase-Shifted Harmonic Sine Oscillation)
// =========================================================================
class _WaveBarsPainter extends CustomPainter {
  final Animation<double> animation;
  final Color primaryColor;
  final Color secondaryColor;
  static const int barCount = 3;

  _WaveBarsPainter({
    required this.animation,
    required this.primaryColor,
    required this.secondaryColor,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final double barWidth = size.width / (barCount * 1.8);
    final double barSpacing = barWidth * 0.5;
    final double totalWidth =
        (barCount * barWidth) + ((barCount - 1) * barSpacing);
    final double startX = (size.width - totalWidth) / 2;

    final double minHeight = size.height * 0.35;
    final double maxHeight = size.height * 0.85;

    final Paint paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < barCount; i++) {
      // Phase angle offset φ for smooth wave progression across bars
      final double phaseShift = i * (math.pi / 2.5);

      // Simple Harmonic Motion equation: y(t) = 0.5 + 0.5 * sin(2π * t - φ)
      final double sineValue =
          0.5 + 0.5 * math.sin((2 * math.pi * animation.value) - phaseShift);

      final double currentBarHeight =
          minHeight + (maxHeight - minHeight) * sineValue;

      final double x = startX + i * (barWidth + barSpacing);
      final double y = (size.height - currentBarHeight) / 2;

      paint.color =
          Color.lerp(primaryColor, secondaryColor, sineValue) ?? primaryColor;

      final RRect roundedBar = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barWidth, currentBarHeight),
        Radius.circular(barWidth / 2),
      );

      canvas.drawRRect(roundedBar, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _WaveBarsPainter oldDelegate) => false;
}

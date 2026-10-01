import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';

class SpinWheelPainter extends CustomPainter {
  final int segmentCount;
  final List<Color> segmentColors;
  final int dotCount;

  const SpinWheelPainter({
    required this.segmentCount,
    this.segmentColors = const [AppColors.wheelSegmentGreen, AppColors.wheelSegmentCream],
    this.dotCount = 24,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2;
    final scale = radius / 165;
    final paint = Paint()..isAntiAlias = true;

    canvas.drawCircle(center, radius, paint..color = AppColors.wheelRimEdge);
    canvas.drawCircle(center, radius - 2 * scale, paint..color = AppColors.wheelRim);

    final dotRadius = radius - 8.5 * scale;
    paint.color = AppColors.white;
    for (var i = 0; i < dotCount; i++) {
      final angle = 2 * pi * i / dotCount;
      canvas.drawCircle(center + Offset(sin(angle), -cos(angle)) * dotRadius, 2.2 * scale, paint);
    }

    final innerRadius = radius - 15 * scale;
    canvas.drawCircle(center, innerRadius, paint..color = AppColors.wheelRimEdge);

    final segmentRadius = innerRadius - 1.5 * scale;
    final rect = Rect.fromCircle(center: center, radius: segmentRadius);
    final sweep = 2 * pi / segmentCount;
    for (var i = 0; i < segmentCount; i++) {
      paint.color = segmentColors[i % segmentColors.length];
      canvas.drawArc(rect, -pi / 2 - sweep / 2 + sweep * i, sweep, true, paint);
    }
  }

  @override
  bool shouldRepaint(SpinWheelPainter oldDelegate) =>
      oldDelegate.segmentCount != segmentCount || oldDelegate.segmentColors != segmentColors;
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../mock_model/wheel_prize_model.dart';
import 'spin_wheel_label.dart';
import 'spin_wheel_painter.dart';

class SpinWheelDisc extends StatelessWidget {
  final List<WheelPrizeModel> prizes;
  final double turns;
  final double diameter;
  final Duration spinDuration;
  final VoidCallback onSpinEnd;

  const SpinWheelDisc({
    super.key,
    required this.prizes,
    required this.turns,
    required this.diameter,
    required this.spinDuration,
    required this.onSpinEnd,
  });

  @override
  Widget build(BuildContext context) {
    final labelWidth = 84.w;
    final labelRadius = diameter / 2 * 0.61;
    final segmentAngle = 2 * pi / prizes.length;
    return Container(
      width: diameter,
      height: diameter,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: AppColors.wheelShadow, offset: Offset(0, 12), blurRadius: 24)],
      ),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: turns),
        duration: spinDuration,
        curve: Curves.easeOutCubic,
        onEnd: onSpinEnd,
        builder: (context, value, child) {
          final wheelAngle = value * 2 * pi;
          return Transform.rotate(
            angle: wheelAngle,
            child: Stack(
              children: [
                Positioned.fill(child: CustomPaint(painter: SpinWheelPainter(segmentCount: prizes.length))),
                for (var i = 0; i < prizes.length; i++)
                  Positioned(
                    left: diameter / 2 + sin(segmentAngle * i) * labelRadius - labelWidth / 2,
                    top: diameter / 2 - cos(segmentAngle * i) * labelRadius - labelWidth / 2,
                    width: labelWidth,
                    height: labelWidth,
                    child: Transform.rotate(
                      angle: -wheelAngle,
                      child: Center(child: SpinWheelLabel(prize: prizes[i])),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

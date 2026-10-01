import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/app_icons.dart';
import '../../../../mock_model/wheel_prize_model.dart';
import 'spin_wheel_hub.dart';
import 'spin_wheel_label.dart';
import 'spin_wheel_painter.dart';

class SpinWheel extends StatelessWidget {
  final List<WheelPrizeModel> prizes;
  final double turns;
  final Duration spinDuration;
  final VoidCallback onSpinEnd;
  final VoidCallback? onHubTap;

  const SpinWheel({
    super.key,
    required this.prizes,
    required this.turns,
    required this.spinDuration,
    required this.onSpinEnd,
    this.onHubTap,
  });

  @override
  Widget build(BuildContext context) {
    final diameter = 330.w;
    final pointerSize = 48.w;
    final pointerOverlap = 30.w;
    final labelWidth = 84.w;
    final labelRadius = diameter / 2 * 0.61;
    final segmentAngle = 2 * pi / prizes.length;

    return SizedBox(
      width: diameter,
      height: diameter + pointerOverlap,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: pointerOverlap,
            child: Container(
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
                              child: Center(
                                child: SpinWheelLabel(
                                  title: prizes[i].titleKey.tr(),
                                  icon: prizes[i].icon,
                                  iconColor: prizes[i].iconColor,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: pointerOverlap + diameter / 2 - 31.w,
            child: SpinWheelHub(onTap: onHubTap),
          ),
          Icon(
            AppIcons.wheelPointer,
            size: pointerSize,
            color: AppColors.wheelPointer,
            shadows: const [Shadow(color: AppColors.wheelShadow, offset: Offset(0, 3), blurRadius: 6)],
          ),
        ],
      ),
    );
  }
}

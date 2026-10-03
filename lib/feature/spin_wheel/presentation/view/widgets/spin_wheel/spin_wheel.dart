import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_shadows.dart';
import '../../../../../../core/utils/app_icons.dart';
import '../../../../mock_model/wheel_prize_model.dart';
import 'spin_wheel_disc.dart';

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
    final pointerOverlap = 30.w;

    return SizedBox(
      width: diameter,
      height: diameter + pointerOverlap,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: pointerOverlap,
            child: SpinWheelDisc(
              prizes: prizes,
              turns: turns,
              diameter: diameter,
              spinDuration: spinDuration,
              onSpinEnd: onSpinEnd,
            ),
          ),
          Positioned(
            top: pointerOverlap + diameter / 2 - 31.w,
            child: GestureDetector(
              onTap: onHubTap,
              child: Container(
                width: 62.w,
                height: 62.w,
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.wheelHub,
                  border: Border.all(color: AppColors.white, width: 3.w),
                  boxShadow: AppShadows.soft,
                ),
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      center: Alignment(0, -0.5),
                      colors: [AppColors.wheelHubLight, AppColors.wheelHub],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Icon(
            AppIcons.wheelPointer,
            size: 48.w,
            color: AppColors.wheelPointer,
            shadows: const [Shadow(color: AppColors.wheelShadow, offset: Offset(0, 3), blurRadius: 6)],
          ),
        ],
      ),
    );
  }
}

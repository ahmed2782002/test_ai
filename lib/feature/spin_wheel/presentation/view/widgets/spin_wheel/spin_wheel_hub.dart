import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_shadows.dart';

class SpinWheelHub extends StatelessWidget {
  final VoidCallback? onTap;

  const SpinWheelHub({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
    );
  }
}

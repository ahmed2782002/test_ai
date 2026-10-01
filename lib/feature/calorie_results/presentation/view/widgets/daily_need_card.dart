import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text.dart';

class DailyNeedCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;

  const DailyNeedCard({super.key, required this.title, required this.value, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 202.h,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.large),
        boxShadow: AppShadows.card,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          PositionedDirectional(
            top: -40.r,
            start: -40.r,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 32.r, sigmaY: 32.r),
              child: Container(
                width: 128.r,
                height: 128.r,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.glow),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                children: [
                  Text(title, style: AppText.highlightTitle, textAlign: TextAlign.center),
                  const Spacer(),
                  Text(value, style: AppText.highlightValue),
                  Text(unit, style: AppText.description),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

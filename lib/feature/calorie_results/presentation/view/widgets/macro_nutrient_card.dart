import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/widgets/app_icon_circle/app_icon_circle.dart';

class MacroNutrientCard extends StatelessWidget {
  final String icon;
  final Size iconSize;
  final Color color;
  final Color lightColor;
  final String name;
  final String value;
  final double progress;

  const MacroNutrientCard({
    super.key,
    required this.icon,
    required this.iconSize,
    required this.color,
    required this.lightColor,
    required this.name,
    required this.value,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: AppShadows.macroCard,
      ),
      child: Row(
        children: [
          AppIconCircle(
            icon: icon,
            size: 48.r,
            iconWidth: iconSize.width.r,
            iconHeight: iconSize.height.r,
            backgroundColor: lightColor,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(name, style: AppText.bodyMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                    ),
                    SizedBox(width: 8.w),
                    Text(value, style: AppText.valueBold.copyWith(color: color)),
                  ],
                ),
                SizedBox(height: 4.h),
                Container(
                  height: 8.h,
                  alignment: AlignmentDirectional.centerStart,
                  decoration: BoxDecoration(
                    color: AppColors.cardBorder,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: progress.clamp(0, 1).toDouble(),
                    heightFactor: 1,
                    child: Container(
                      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(AppRadius.pill)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

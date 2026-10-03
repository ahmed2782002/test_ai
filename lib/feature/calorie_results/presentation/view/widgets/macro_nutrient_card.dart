import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/widgets/app_icon_circle/app_icon_circle.dart';
import '../../../mock_model/calorie_results_model.dart';

class MacroNutrientCard extends StatelessWidget {
  final MacroNutrient macro;

  const MacroNutrientCard({super.key, required this.macro});

  @override
  Widget build(BuildContext context) {
    final type = macro.type;
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
            icon: type.icon,
            size: 48.r,
            iconWidth: type.iconSize.width.r,
            iconHeight: type.iconSize.height.r,
            backgroundColor: type.lightColor,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        type.labelKey.tr(context: context),
                        style: AppText.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '${macro.grams}${'calorie_results.gram'.tr(context: context)}',
                      style: AppText.valueBold.copyWith(color: type.color),
                    ),
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
                    widthFactor: macro.progress.clamp(0, 1).toDouble(),
                    heightFactor: 1,
                    child: Container(
                      decoration: BoxDecoration(color: type.color, borderRadius: BorderRadius.circular(AppRadius.pill)),
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

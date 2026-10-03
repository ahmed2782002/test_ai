import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/widgets/app_svg_icon/app_svg_icon.dart';
import '../../../mock_model/activity_level_model.dart';

class ActivityLevelCard extends StatelessWidget {
  final ActivityLevelModel level;
  final bool isSelected;
  final VoidCallback onTap;

  const ActivityLevelCard({super.key, required this.level, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primaryDark : AppColors.textMuted;
    final size = level.iconSize;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 140.w,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLight : AppColors.optionBackground,
          borderRadius: BorderRadius.circular(AppRadius.small),
          border: Border.all(color: isSelected ? AppColors.primaryDark : AppColors.optionBorder),
          boxShadow: AppShadows.option,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 48.r,
                    height: 48.r,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: isSelected ? AppColors.white : AppColors.optionIconBackground, shape: BoxShape.circle),
                    child: level.iconAsset != null
                        ? AppSvgIcon(asset: level.iconAsset!, width: size.width.r, height: size.height.r, color: color)
                        : Icon(level.icon, size: size.width.r, color: color),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    level.titleKey.tr(context: context),
                    style: isSelected ? AppText.optionTitleSelected : AppText.optionTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (isSelected)
              PositionedDirectional(
                top: 10.h,
                start: 9.w,
                child: AppSvgIcon(asset: AppIcons.checkCircle, width: 13.33.r, height: 13.33.r),
              ),
          ],
        ),
      ),
    );
  }
}

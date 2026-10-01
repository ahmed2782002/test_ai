import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/widgets/app_svg_icon/app_svg_icon.dart';

class ActivityLevelCard extends StatelessWidget {
  final String title;
  final String? iconAsset;
  final IconData? icon;
  final Size iconSize;
  final bool isSelected;
  final VoidCallback onTap;

  const ActivityLevelCard({
    super.key,
    required this.title,
    this.iconAsset,
    this.icon,
    required this.iconSize,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = isSelected ? AppColors.primaryDark : AppColors.textMuted;
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
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 48.r,
                      height: 48.r,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.white : AppColors.optionIconBackground,
                        shape: BoxShape.circle,
                      ),
                      child: iconAsset != null
                          ? AppSvgIcon(
                              asset: iconAsset!,
                              width: iconSize.width.r,
                              height: iconSize.height.r,
                              color: iconColor,
                            )
                          : Icon(icon, size: iconSize.width.r, color: iconColor),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      title,
                      style: isSelected ? AppText.optionTitleSelected : AppText.optionTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
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

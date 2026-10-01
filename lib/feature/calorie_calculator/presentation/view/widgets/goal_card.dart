import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/widgets/app_svg_icon/app_svg_icon.dart';

class GoalCard extends StatelessWidget {
  final String title;
  final String icon;
  final Size iconSize;
  final Color iconColor;
  final Color iconBackground;
  final bool isSelected;
  final VoidCallback onTap;

  const GoalCard({
    super.key,
    required this.title,
    required this.icon,
    required this.iconSize,
    required this.iconColor,
    required this.iconBackground,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLight : AppColors.optionBackground,
          borderRadius: BorderRadius.circular(AppRadius.small),
          border: Border.all(color: isSelected ? AppColors.primaryDark : AppColors.optionBorder),
          boxShadow: AppShadows.option,
        ),
        child: Row(
          children: [
            Container(
              width: 40.r,
              height: 40.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.white : iconBackground,
                shape: BoxShape.circle,
              ),
              child: AppSvgIcon(
                asset: icon,
                width: iconSize.width.r,
                height: iconSize.height.r,
                color: iconColor,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(title, style: isSelected ? AppText.optionTitleSelected : AppText.optionTitle),
            ),
            if (isSelected) AppSvgIcon(asset: AppIcons.checkCircle, width: 20.r, height: 20.r),
          ],
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/widgets/app_icon_circle/app_icon_circle.dart';
import '../../../../../core/widgets/app_svg_icon/app_svg_icon.dart';
import '../../../mock_model/goal_model.dart';

class GoalCard extends StatelessWidget {
  final GoalModel goal;
  final bool isSelected;
  final VoidCallback onTap;

  const GoalCard({super.key, required this.goal, required this.isSelected, required this.onTap});

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
            AppIconCircle(
              icon: goal.icon,
              size: 40.r,
              iconWidth: goal.iconSize.width.r,
              iconHeight: goal.iconSize.height.r,
              iconColor: goal.iconColor,
              backgroundColor: isSelected ? AppColors.white : goal.iconBackground,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                goal.titleKey.tr(context: context),
                style: isSelected ? AppText.optionTitleSelected : AppText.optionTitle,
              ),
            ),
            if (isSelected) AppSvgIcon(asset: AppIcons.checkCircle, width: 20.r, height: 20.r),
          ],
        ),
      ),
    );
  }
}

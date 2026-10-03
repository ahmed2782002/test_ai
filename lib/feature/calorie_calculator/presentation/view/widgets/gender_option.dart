import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/widgets/app_svg_icon/app_svg_icon.dart';

class GenderOption extends StatelessWidget {
  final String label;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderOption({super.key, required this.label, required this.icon, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final contentColor = isSelected ? AppColors.white : AppColors.optionText;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 98.w,
        height: 42.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.fieldBackground,
          borderRadius: BorderRadius.circular(AppRadius.small),
          border: Border.all(color: isSelected ? AppColors.primary : AppColors.divider),
          boxShadow: isSelected ? AppShadows.option : null,
        ),
        child: Stack(
          children: [
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      label,
                      style: AppText.option.copyWith(color: contentColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  AppSvgIcon(asset: icon, width: 16.r, height: 16.r, color: contentColor),
                ],
              ),
            ),
            if (isSelected)
              PositionedDirectional(
                top: 4.h,
                end: 4.w,
                child: Container(
                  width: 16.r,
                  height: 16.r,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
                  child: Icon(AppIcons.check, size: 12.r, color: AppColors.primary),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

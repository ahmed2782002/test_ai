import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/widgets/app_svg_icon/app_svg_icon.dart';

class QuickActionItem extends StatelessWidget {
  final String icon;
  final double iconHeight;
  final String label;
  final VoidCallback onTap;

  const QuickActionItem({super.key, required this.icon, required this.iconHeight, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 72.w),
        child: Column(
          children: [
            Container(
              width: 55.r,
              height: 55.r,
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: AppColors.white, shape: BoxShape.circle, boxShadow: AppShadows.option),
              child: AppSvgIcon(asset: icon, height: iconHeight.r),
            ),
            SizedBox(height: 9.h),
            Text(label, style: AppText.quickActionLabel, maxLines: 1, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

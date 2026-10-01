import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/widgets/app_svg_icon/app_svg_icon.dart';

class HealthTipCard extends StatelessWidget {
  final String title;
  final String body;

  const HealthTipCard({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.tipBackground,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: AppColors.tipBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppText.accentTitle),
                SizedBox(height: 2.h),
                Text(body, style: AppText.homeBody),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          AppSvgIcon(asset: AppIcons.tip, width: 24.r, height: 24.r),
        ],
      ),
    );
  }
}

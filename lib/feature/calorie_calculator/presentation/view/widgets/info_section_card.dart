import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/widgets/app_svg_icon/app_svg_icon.dart';

class InfoSectionCard extends StatelessWidget {
  final String title;
  final String icon;
  final List<Widget> children;

  const InfoSectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.large),
        boxShadow: AppShadows.infoCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              AppSvgIcon(asset: icon, width: 20.r, height: 20.r),
              SizedBox(width: 8.w),
              Expanded(child: Text(title, style: AppText.cardTitle)),
            ],
          ),
          SizedBox(height: 12.h),
          const Divider(height: 1, thickness: 1, color: AppColors.fieldBorder),
          for (final child in children) ...[SizedBox(height: 20.h), child],
        ],
      ),
    );
  }
}

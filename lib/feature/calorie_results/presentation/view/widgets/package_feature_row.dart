import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/widgets/app_icon_circle/app_icon_circle.dart';

class PackageFeatureRow extends StatelessWidget {
  final String icon;
  final Size iconSize;
  final String title;

  const PackageFeatureRow({super.key, required this.icon, required this.iconSize, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppIconCircle(
          icon: icon,
          size: 32.r,
          iconWidth: iconSize.width.r,
          iconHeight: iconSize.height.r,
          backgroundColor: AppColors.iconCircle,
        ),
        SizedBox(width: 12.w),
        Expanded(child: Text(title, style: AppText.bodyMedium)),
      ],
    );
  }
}

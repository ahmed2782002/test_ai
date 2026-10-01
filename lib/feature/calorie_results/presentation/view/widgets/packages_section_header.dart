import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/widgets/app_svg_icon/app_svg_icon.dart';

class PackagesSectionHeader extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback onAction;

  const PackagesSectionHeader({super.key, required this.title, required this.actionText, required this.onAction});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppSvgIcon(asset: AppIcons.packagesStar, width: 20.r, height: 19.r),
        SizedBox(width: 8.w),
        Expanded(child: Text(title, style: AppText.packagesTitle, maxLines: 1, overflow: TextOverflow.ellipsis)),
        GestureDetector(
          onTap: onAction,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Text(actionText, style: AppText.link),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_text.dart';
import '../../utils/app_icons.dart';
import '../app_svg_icon/app_svg_icon.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const AppHeader({super.key, required this.title, this.onBack});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 56.w),
            child: Text(
              title,
              style: AppText.headerTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (onBack != null)
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: IconButton(
                onPressed: onBack,
                icon: AppSvgIcon(asset: AppIcons.back, width: 12.r, height: 12.r, matchTextDirection: true),
              ),
            ),
        ],
      ),
    );
  }
}

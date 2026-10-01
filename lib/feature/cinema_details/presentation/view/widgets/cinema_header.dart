import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/widgets/app_svg_icon/app_svg_icon.dart';

class CinemaHeader extends StatelessWidget {
  final String image;
  final VoidCallback onBack;
  final Widget panel;

  const CinemaHeader({super.key, required this.image, required this.onBack, required this.panel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 289.h,
          child: const ColoredBox(color: AppColors.cinemaHeaderBackground),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 185.h,
          child: Image.asset(image, fit: BoxFit.cover),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(top: 185.h, start: 8.w, end: 12.w),
          child: panel,
        ),
        PositionedDirectional(
          top: MediaQuery.paddingOf(context).top,
          start: 12.w,
          child: IconButton(
            onPressed: onBack,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints.tightFor(width: 40.r, height: 32.r),
            icon: AppSvgIcon(
              asset: AppIcons.back,
              width: 20.r,
              height: 20.r,
              color: AppColors.white,
              matchTextDirection: true,
            ),
          ),
        ),
      ],
    );
  }
}

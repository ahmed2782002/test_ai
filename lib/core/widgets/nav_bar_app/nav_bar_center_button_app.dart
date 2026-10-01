import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_shadows.dart';
import '../app_svg_icon/app_svg_icon.dart';

class NavBarCenterButtonApp extends StatelessWidget {
  final String icon;
  final double size;
  final VoidCallback onTap;

  const NavBarCenterButtonApp({super.key, required this.icon, required this.size, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.primaryDark,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.optionBackground, width: 4.r),
          boxShadow: AppShadows.navButton,
        ),
        alignment: Alignment.center,
        child: AppSvgIcon(asset: icon, width: 20.r, height: 20.r, color: AppColors.white),
      ),
    );
  }
}

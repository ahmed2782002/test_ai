import 'package:flutter/material.dart';

import '../app_svg_icon/app_svg_icon.dart';

class AppIconCircle extends StatelessWidget {
  final String icon;
  final double size;
  final double iconWidth;
  final double iconHeight;
  final Color? iconColor;
  final Color backgroundColor;

  const AppIconCircle({
    super.key,
    required this.icon,
    required this.size,
    required this.iconWidth,
    required this.iconHeight,
    this.iconColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: AppSvgIcon(asset: icon, width: iconWidth, height: iconHeight, color: iconColor),
    );
  }
}

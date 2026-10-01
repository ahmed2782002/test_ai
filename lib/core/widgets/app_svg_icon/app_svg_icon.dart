import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSvgIcon extends StatelessWidget {
  final String asset;
  final double? width;
  final double? height;
  final Color? color;
  final bool matchTextDirection;

  const AppSvgIcon({
    super.key,
    required this.asset,
    this.width,
    this.height,
    this.color,
    this.matchTextDirection = false,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: width,
      height: height,
      matchTextDirection: matchTextDirection,
      colorFilter: color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
    );
  }
}

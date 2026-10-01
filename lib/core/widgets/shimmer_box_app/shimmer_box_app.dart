import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class ShimmerBoxApp extends StatelessWidget {
  final double? width;
  final double height;
  final double radius;
  final bool isCircle;

  const ShimmerBoxApp({super.key, this.width, required this.height, this.radius = 0, this.isCircle = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isCircle ? height : width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.shimmerBase,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : BorderRadius.circular(radius),
      ),
    );
  }
}

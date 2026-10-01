import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_text.dart';

class SpinWheelLabel extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;

  const SpinWheelLabel({super.key, required this.title, required this.icon, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 30.r, color: iconColor),
        SizedBox(height: 4.h),
        Text(title, textAlign: TextAlign.center, maxLines: 2, style: AppText.wheelLabel),
      ],
    );
  }
}

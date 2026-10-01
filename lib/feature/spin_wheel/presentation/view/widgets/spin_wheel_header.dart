import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text.dart';

class SpinWheelHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const SpinWheelHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('🎁', style: AppText.spinTitle),
            SizedBox(width: 8.w),
            Flexible(child: Text(title, textAlign: TextAlign.center, style: AppText.spinTitle)),
          ],
        ),
        SizedBox(height: 4.h),
        Text(subtitle, textAlign: TextAlign.center, style: AppText.spinSubtitle),
      ],
    );
  }
}

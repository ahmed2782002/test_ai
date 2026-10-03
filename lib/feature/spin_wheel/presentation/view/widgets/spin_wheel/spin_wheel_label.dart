import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_text.dart';
import '../../../../mock_model/wheel_prize_model.dart';

class SpinWheelLabel extends StatelessWidget {
  final WheelPrizeModel prize;

  const SpinWheelLabel({super.key, required this.prize});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(prize.icon, size: 30.r, color: prize.iconColor),
        SizedBox(height: 4.h),
        Text(prize.titleKey.tr(), textAlign: TextAlign.center, maxLines: 2, style: AppText.wheelLabel),
      ],
    );
  }
}

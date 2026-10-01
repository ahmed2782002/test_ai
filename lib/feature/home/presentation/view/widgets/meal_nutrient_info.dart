import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text.dart';
import '../../../../../core/widgets/app_svg_icon/app_svg_icon.dart';

class MealNutrientInfo extends StatelessWidget {
  final String icon;
  final String text;

  const MealNutrientInfo({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(text, style: AppText.grayCaption),
        SizedBox(width: 4.w),
        AppSvgIcon(asset: icon, width: 14.r, height: 14.r),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';

class StepsWeeklyBars extends StatelessWidget {
  final List<double> factors;

  const StepsWeeklyBars({super.key, required this.factors});

  @override
  Widget build(BuildContext context) {
    final maxHeight = 32.h;
    return SizedBox(
      height: maxHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var index = 0; index < factors.length; index++)
            Padding(
              padding: EdgeInsetsDirectional.only(start: index == 0 ? 0 : 4.w),
              child: Container(
                width: 6.w,
                height: maxHeight * factors[index],
                decoration: BoxDecoration(
                  color: index == factors.length - 1 ? AppColors.stepsAccent : AppColors.stepsAccentLight,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(2.r)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

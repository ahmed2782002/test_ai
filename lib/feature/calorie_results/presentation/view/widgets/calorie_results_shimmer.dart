import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';

class CalorieResultsShimmer extends StatelessWidget {
  const CalorieResultsShimmer({super.key});

  Widget box({required double height, double? width, double? radius}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(radius ?? AppRadius.medium),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: box(height: 16.h, width: 280.w, radius: AppRadius.xSmall)),
            SizedBox(height: 22.h),
            box(height: 202.h, radius: AppRadius.large),
            SizedBox(height: 20.h),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: box(height: 18.h, width: 140.w, radius: AppRadius.xSmall),
            ),
            SizedBox(height: 14.h),
            for (var i = 0; i < 3; i++) ...[
              box(height: 82.h),
              SizedBox(height: 12.h),
            ],
            SizedBox(height: 12.h),
            box(height: 20.h, radius: AppRadius.xSmall),
            SizedBox(height: 18.h),
            box(height: 360.h, radius: AppRadius.large),
          ],
        ),
      ),
    );
  }
}

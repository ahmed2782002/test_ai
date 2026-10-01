import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/widgets/shimmer_box_app/shimmer_app.dart';
import '../../../../../core/widgets/shimmer_box_app/shimmer_box_app.dart';

class CinemaDetailsShimmer extends StatelessWidget {
  const CinemaDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerApp(
      baseColor: AppColors.cinemaShimmerBase,
      highlightColor: AppColors.cinemaShimmerHighlight,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerBoxApp(width: double.infinity, height: 338.h),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 17.w),
              child: ShimmerBoxApp(width: 110.w, height: 26.h, radius: AppRadius.xSmall),
            ),
            SizedBox(height: 14.h),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 16.w, end: 12.w),
              child: Row(
                children: [
                  Expanded(child: ShimmerBoxApp(height: 265.h, radius: AppRadius.compact)),
                  SizedBox(width: 14.w),
                  Expanded(child: ShimmerBoxApp(height: 265.h, radius: AppRadius.compact)),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            for (var index = 0; index < 3; index++) ...[
              Padding(
                padding: EdgeInsetsDirectional.only(start: 16.w),
                child: ShimmerBoxApp(width: 150.w, height: 14.h, radius: AppRadius.xSmall),
              ),
              SizedBox(height: 8.h),
            ],
            SizedBox(height: 24.h),
            for (var index = 0; index < 3; index++) ...[
              Padding(
                padding: EdgeInsetsDirectional.only(start: 10.w, end: 37.w),
                child: ShimmerBoxApp(width: double.infinity, height: 59.h, radius: AppRadius.medium),
              ),
              SizedBox(height: 22.h),
            ],
          ],
        ),
      ),
    );
  }
}

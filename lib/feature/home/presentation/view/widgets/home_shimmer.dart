import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/widgets/shimmer_box_app/shimmer_app.dart';
import '../../../../../core/widgets/shimmer_box_app/shimmer_box_app.dart';

class HomeShimmer extends StatelessWidget {
  final EdgeInsets padding;

  const HomeShimmer({super.key, required this.padding});

  @override
  Widget build(BuildContext context) {
    return ShimmerApp(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: padding,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                ShimmerBoxApp(height: 44.r, isCircle: true),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerBoxApp(width: 110.w, height: 14.h, radius: AppRadius.xSmall),
                      SizedBox(height: 8.h),
                      ShimmerBoxApp(width: 150.w, height: 10.h, radius: AppRadius.xSmall),
                    ],
                  ),
                ),
                ShimmerBoxApp(height: 40.r, isCircle: true),
              ],
            ),
          ),
          SizedBox(height: 30.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: ShimmerBoxApp(height: 50.h, radius: AppRadius.small),
          ),
          SizedBox(height: 22.h),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 8.w, end: 24.w),
            child: ShimmerBoxApp(height: 186.h, radius: AppRadius.small),
          ),
          SizedBox(height: 22.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var index = 0; index < 4; index++)
                  Column(
                    children: [
                      ShimmerBoxApp(height: 55.r, isCircle: true),
                      SizedBox(height: 10.h),
                      ShimmerBoxApp(width: 50.w, height: 12.h, radius: AppRadius.xSmall),
                    ],
                  ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: ShimmerBoxApp(height: 312.h, radius: AppRadius.medium),
          ),
          SizedBox(height: 28.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              children: [
                Expanded(child: ShimmerBoxApp(height: 212.h, radius: AppRadius.medium)),
                SizedBox(width: 12.w),
                Expanded(child: ShimmerBoxApp(height: 212.h, radius: AppRadius.medium)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

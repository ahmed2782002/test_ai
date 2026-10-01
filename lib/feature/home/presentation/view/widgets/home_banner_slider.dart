import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../mock_model/home_banner_model.dart';

class HomeBannerSlider extends StatelessWidget {
  final List<HomeBannerModel> banners;
  final PageController controller;
  final ValueChanged<HomeBannerModel> onBannerTap;

  const HomeBannerSlider({super.key, required this.banners, required this.controller, required this.onBannerTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 186.h,
      child: PageView.builder(
        controller: controller,
        padEnds: false,
        itemCount: banners.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsetsDirectional.only(start: 8.w, end: 9.w),
          child: GestureDetector(
            onTap: () => onBannerTap(banners[index]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.asset(banners[index].image, fit: BoxFit.cover, width: double.infinity),
            ),
          ),
        ),
      ),
    );
  }
}

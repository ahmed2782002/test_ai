import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../mock_model/home_model.dart';
import 'quick_action_item.dart';

class HomeBannerActions extends StatelessWidget {
  final List<String> banners;
  final PageController bannerController;
  final List<QuickActionType> actions;
  final ValueChanged<int> onBannerTap;
  final ValueChanged<QuickActionType> onActionTap;

  const HomeBannerActions({
    super.key,
    required this.banners,
    required this.bannerController,
    required this.actions,
    required this.onBannerTap,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 186.h,
          child: PageView.builder(
            controller: bannerController,
            padEnds: false,
            itemCount: banners.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsetsDirectional.only(start: 8.w, end: 9.w),
              child: GestureDetector(
                onTap: () => onBannerTap(index),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Image.asset(banners[index], fit: BoxFit.cover, width: double.infinity),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var index = 0; index < actions.length; index++)
                Padding(
                  padding: EdgeInsetsDirectional.only(start: index == 0 ? 0 : 8.w),
                  child: QuickActionItem(
                    icon: actions[index].icon,
                    iconHeight: actions[index].iconHeight,
                    label: context.tr(actions[index].translationKey),
                    onTap: () => onActionTap(actions[index]),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

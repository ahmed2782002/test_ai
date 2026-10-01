import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/widgets/app_primary_button/app_primary_button.dart';
import '../../../../../core/widgets/app_svg_icon/app_svg_icon.dart';

class PackageCard extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  final String price;
  final String currency;
  final String period;
  final String? badgeText;
  final List<Widget> features;
  final String actionText;
  final VoidCallback onAction;

  const PackageCard({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.currency,
    required this.period,
    this.badgeText,
    required this.features,
    required this.actionText,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.large),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: AppShadows.card,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Image.asset(image, height: 192.h, width: double.infinity, fit: BoxFit.cover),
              if (badgeText != null)
                PositionedDirectional(
                  top: 16.h,
                  start: 16.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      boxShadow: AppShadows.option,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppSvgIcon(asset: AppIcons.goalTarget, width: 10.67.r, height: 12.67.r),
                        SizedBox(width: 4.w),
                        Text(badgeText!, style: AppText.tag),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(24.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name, style: AppText.packageTitle),
                          SizedBox(height: 4.h),
                          Text(description, style: AppText.description),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(price, style: AppText.packagePrice),
                            SizedBox(width: 2.w),
                            Text(currency, style: AppText.currency),
                          ],
                        ),
                        Text(period, style: AppText.description),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                const Divider(height: 1, thickness: 1, color: AppColors.cardBorder),
                SizedBox(height: 24.h),
                for (var i = 0; i < features.length; i++) ...[
                  if (i > 0) SizedBox(height: 12.h),
                  features[i],
                ],
                SizedBox(height: 32.h),
                AppPrimaryButton(
                  text: actionText,
                  onPressed: onAction,
                  trailingIcon: AppIcons.forward,
                  borderRadius: AppRadius.large,
                  trailingIconSize: 16.r,
                  textStyle: AppText.buttonMedium,
                  shadow: AppShadows.button,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

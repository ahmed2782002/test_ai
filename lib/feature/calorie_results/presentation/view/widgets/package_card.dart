import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/widgets/app_svg_icon/app_svg_icon.dart';
import '../../../mock_model/package_model.dart';
import 'package_details.dart';

class PackageCard extends StatelessWidget {
  final PackageModel package;
  final VoidCallback onSubscribe;

  const PackageCard({super.key, required this.package, required this.onSubscribe});

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
              Image.asset(package.image, height: 192.h, width: double.infinity, fit: BoxFit.cover),
              if (package.fitsGoal)
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
                        Text('calorie_results.fits_goal'.tr(context: context), style: AppText.tag),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          PackageDetails(package: package, onSubscribe: onSubscribe),
        ],
      ),
    );
  }
}

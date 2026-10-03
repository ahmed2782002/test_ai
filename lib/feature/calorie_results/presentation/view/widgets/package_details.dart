import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/widgets/app_primary_button/app_primary_button.dart';
import '../../../mock_model/package_model.dart';
import 'package_feature_row.dart';

class PackageDetails extends StatelessWidget {
  final PackageModel package;
  final VoidCallback onSubscribe;

  const PackageDetails({super.key, required this.package, required this.onSubscribe});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    Text(package.name.tr(context: context), style: AppText.packageTitle),
                    SizedBox(height: 4.h),
                    Text(package.description.tr(context: context), style: AppText.description),
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
                      Text('${package.monthlyPrice}', style: AppText.packagePrice),
                      SizedBox(width: 2.w),
                      Text('calorie_results.currency'.tr(context: context), style: AppText.currency),
                    ],
                  ),
                  Text('calorie_results.per_month'.tr(context: context), style: AppText.description),
                ],
              ),
            ],
          ),
          SizedBox(height: 24.h),
          const Divider(height: 1, thickness: 1, color: AppColors.cardBorder),
          SizedBox(height: 24.h),
          for (var i = 0; i < package.features.length; i++) ...[
            if (i > 0) SizedBox(height: 12.h),
            PackageFeatureRow(feature: package.features[i]),
          ],
          SizedBox(height: 32.h),
          AppPrimaryButton(
            text: 'calorie_results.subscribe'.tr(context: context),
            onPressed: onSubscribe,
            trailingIcon: AppIcons.forward,
            borderRadius: AppRadius.large,
            trailingIconSize: 16.r,
            textStyle: AppText.buttonMedium,
            shadow: AppShadows.button,
          ),
        ],
      ),
    );
  }
}

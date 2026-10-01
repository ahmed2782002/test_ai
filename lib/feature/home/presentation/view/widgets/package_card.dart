import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_digits.dart';
import '../../../mock_model/package_model.dart';

class PackageCard extends StatelessWidget {
  final PackageModel package;
  final VoidCallback onTap;

  const PackageCard({super.key, required this.package, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final languageCode = context.locale.languageCode;
    final mealsPerDay = context.plural(
      'home.meals_per_day',
      package.mealsPerDay,
      args: [AppDigits.format(package.mealsPerDay, languageCode)],
    );
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 168.w,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.medium),
          boxShadow: AppShadows.homeCard,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(package.image, height: 100.h, fit: BoxFit.cover),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    package.name.of(languageCode),
                    style: AppText.homeTitleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${context.tr(package.period.translationKey)} / $mealsPerDay',
                    style: AppText.packageDuration,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    context.tr('home.price', args: [AppDigits.format(package.price, languageCode)]),
                    style: AppText.price,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

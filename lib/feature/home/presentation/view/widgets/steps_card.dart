import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_digits.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/widgets/app_svg_icon/app_svg_icon.dart';
import '../../../mock_model/steps_model.dart';
import 'steps_weekly_bars.dart';

class StepsCard extends StatelessWidget {
  final StepsModel steps;
  final List<double> weeklyFactors;
  final VoidCallback onTap;

  const StepsCard({super.key, required this.steps, required this.weeklyFactors, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final languageCode = context.locale.languageCode;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.xLarge),
          boxShadow: AppShadows.mutedCard,
        ),
        child: Row(
          children: [
            AppSvgIcon(asset: AppIcons.stepsRing, width: 56.r, height: 56.r),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr('home.today_steps', args: [AppDigits.format(steps.todaySteps, languageCode)]),
                    style: AppText.homeTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    context.tr('home.steps_goal', args: [AppDigits.format(steps.goal, languageCode)]),
                    style: AppText.mutedCaption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            StepsWeeklyBars(factors: weeklyFactors),
          ],
        ),
      ),
    );
  }
}

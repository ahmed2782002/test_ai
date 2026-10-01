import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_digits.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../mock_model/meal_model.dart';
import 'meal_nutrient_info.dart';

class SuggestedMealCard extends StatelessWidget {
  final MealModel meal;
  final VoidCallback onViewMeal;

  const SuggestedMealCard({super.key, required this.meal, required this.onViewMeal});

  @override
  Widget build(BuildContext context) {
    final languageCode = context.locale.languageCode;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        boxShadow: AppShadows.homeCard,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(meal.image, height: 160.h, fit: BoxFit.cover),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.w, 20.h, 16.w, 15.h),
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
                          Text(context.tr('home.meal_of_the_day'), style: AppText.accentCaption),
                          SizedBox(height: 16.h),
                          Text(meal.name.of(languageCode), style: AppText.mealTitle),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        MealNutrientInfo(
                          icon: AppIcons.calories,
                          text: context.tr('home.calories_value', args: [AppDigits.format(meal.calories, languageCode)]),
                        ),
                        SizedBox(height: 18.h),
                        MealNutrientInfo(
                          icon: AppIcons.protein,
                          text: context.tr('home.protein_value', args: [AppDigits.format(meal.protein, languageCode)]),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Material(
                  color: AppColors.neutralBackground,
                  borderRadius: BorderRadius.circular(AppRadius.small),
                  child: InkWell(
                    onTap: onViewMeal,
                    borderRadius: BorderRadius.circular(AppRadius.small),
                    child: SizedBox(
                      height: 40.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(context.tr('home.view_meal'), style: AppText.mealAction),
                          SizedBox(width: 8.w),
                          Icon(AppIcons.forward, size: 14.r, color: AppColors.accent),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

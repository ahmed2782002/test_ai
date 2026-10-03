import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_icons.dart';
import '../../../core/utils/app_images.dart';
import 'package_model.dart';

enum MacroType {
  protein('calorie_results.protein', AppIcons.proteinPlate, Size(22, 19), AppColors.primaryDark, AppColors.primaryLight),
  carbs('calorie_results.carbs', AppIcons.carbs, Size(22, 14), AppColors.stepsAccent, AppColors.lossIconBackground),
  fats('calorie_results.fats', AppIcons.fats, Size(14, 18), AppColors.gainIcon, AppColors.slateLight);

  final String labelKey;
  final String icon;
  final Size iconSize;
  final Color color;
  final Color lightColor;

  const MacroType(this.labelKey, this.icon, this.iconSize, this.color, this.lightColor);
}

typedef MacroNutrient = ({MacroType type, int grams, double progress});

class CalorieResultsModel {
  final int dailyCalories;
  final List<MacroNutrient> macros;
  final List<PackageModel> packages;

  const CalorieResultsModel({required this.dailyCalories, required this.macros, required this.packages});

  static const CalorieResultsModel mock = CalorieResultsModel(
    dailyCalories: 2450,
    macros: [
      (type: MacroType.protein, grams: 150, progress: 0.4),
      (type: MacroType.carbs, grams: 280, progress: 0.6),
      (type: MacroType.fats, grams: 65, progress: 0.25),
    ],
    packages: [
      PackageModel(
        name: 'calorie_results.mock.healthy_balance_name',
        description: 'calorie_results.mock.healthy_balance_description',
        image: AppImages.testHealthyBalancePackage,
        monthlyPrice: 899,
        fitsGoal: true,
        features: [
          (icon: AppIcons.meals, iconSize: Size(11.25, 15), title: 'calorie_results.mock.meals_per_day'),
          (icon: AppIcons.delivery, iconSize: Size(16.5, 12), title: 'calorie_results.mock.free_delivery'),
          (icon: AppIcons.nutritionist, iconSize: Size(15, 13.5), title: 'calorie_results.mock.free_consultation'),
        ],
      ),
    ],
  );
}

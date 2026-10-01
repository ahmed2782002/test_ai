import 'package:flutter/widgets.dart';

import '../../../core/utils/app_icons.dart';
import '../../../core/utils/app_images.dart';
import 'calorie_results_model.dart';
import 'macro_nutrient_model.dart';
import 'macro_type.dart';
import 'package_feature_model.dart';
import 'package_model.dart';

abstract final class CalorieResultsMock {
  static const CalorieResultsModel data = CalorieResultsModel(
    dailyCalories: 2450,
    macros: [
      MacroNutrientModel(type: MacroType.protein, grams: 150, progress: 0.4),
      MacroNutrientModel(type: MacroType.carbs, grams: 280, progress: 0.6),
      MacroNutrientModel(type: MacroType.fats, grams: 65, progress: 0.25),
    ],
    packages: [
      PackageModel(
        name: 'calorie_results.mock.healthy_balance_name',
        description: 'calorie_results.mock.healthy_balance_description',
        image: AppImages.testHealthyBalancePackage,
        monthlyPrice: 899,
        fitsGoal: true,
        features: [
          PackageFeatureModel(icon: AppIcons.meals, iconSize: Size(11.25, 15), title: 'calorie_results.mock.meals_per_day'),
          PackageFeatureModel(icon: AppIcons.delivery, iconSize: Size(16.5, 12), title: 'calorie_results.mock.free_delivery'),
          PackageFeatureModel(icon: AppIcons.nutritionist, iconSize: Size(15, 13.5), title: 'calorie_results.mock.free_consultation'),
        ],
      ),
    ],
  );
}

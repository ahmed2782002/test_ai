import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_icons.dart';

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

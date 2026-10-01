import 'package:flutter/widgets.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_icons.dart';

class GoalModel {
  final String titleKey;
  final String icon;
  final Size iconSize;
  final Color iconColor;
  final Color iconBackground;

  const GoalModel({
    required this.titleKey,
    required this.icon,
    required this.iconSize,
    required this.iconColor,
    required this.iconBackground,
  });

  static const List<GoalModel> mock = [
    GoalModel(
      titleKey: 'calorie_calculator.goal.lose',
      icon: AppIcons.loseWeight,
      iconSize: Size(20, 12),
      iconColor: AppColors.lossIcon,
      iconBackground: AppColors.lossIconBackground,
    ),
    GoalModel(
      titleKey: 'calorie_calculator.goal.maintain',
      icon: AppIcons.maintainWeight,
      iconSize: Size(19, 9),
      iconColor: AppColors.primaryDark,
      iconBackground: AppColors.optionIconBackground,
    ),
    GoalModel(
      titleKey: 'calorie_calculator.goal.gain',
      icon: AppIcons.gainWeight,
      iconSize: Size(20, 12),
      iconColor: AppColors.gainIcon,
      iconBackground: AppColors.optionIconBackground,
    ),
  ];
}

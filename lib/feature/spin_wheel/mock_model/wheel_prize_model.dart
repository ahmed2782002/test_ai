import 'package:flutter/widgets.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_icons.dart';

class WheelPrizeModel {
  final String titleKey;
  final IconData icon;
  final Color iconColor;

  const WheelPrizeModel({required this.titleKey, required this.icon, required this.iconColor});

  static const List<WheelPrizeModel> mock = [
    WheelPrizeModel(titleKey: 'spin_wheel.prizes.free_meal', icon: AppIcons.gift, iconColor: AppColors.primaryDark),
    WheelPrizeModel(titleKey: 'spin_wheel.prizes.discount_20', icon: AppIcons.discountTag, iconColor: AppColors.primaryDark),
    WheelPrizeModel(titleKey: 'spin_wheel.prizes.surprise_gift', icon: AppIcons.surpriseGift, iconColor: AppColors.primaryDark),
    WheelPrizeModel(titleKey: 'spin_wheel.prizes.free_diet_plan', icon: AppIcons.dietPlan, iconColor: AppColors.primaryDark),
    WheelPrizeModel(titleKey: 'spin_wheel.prizes.double_points', icon: AppIcons.star, iconColor: AppColors.white),
    WheelPrizeModel(titleKey: 'spin_wheel.prizes.free_consultation', icon: AppIcons.consultation, iconColor: AppColors.primaryDark),
    WheelPrizeModel(titleKey: 'spin_wheel.prizes.discount_10', icon: AppIcons.percentTag, iconColor: AppColors.primaryDark),
    WheelPrizeModel(titleKey: 'spin_wheel.prizes.extra_meal', icon: AppIcons.extraMeal, iconColor: AppColors.stepsAccent),
  ];
}

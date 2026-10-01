import 'package:flutter/widgets.dart';

import '../../../core/utils/app_icons.dart';

class ActivityLevelModel {
  final String titleKey;
  final String? iconAsset;
  final IconData? icon;
  final Size iconSize;

  const ActivityLevelModel({required this.titleKey, this.iconAsset, this.icon, required this.iconSize});

  static const List<ActivityLevelModel> mock = [
    ActivityLevelModel(titleKey: 'calorie_calculator.activity.sedentary', iconAsset: AppIcons.sedentary, iconSize: Size(22, 18)),
    ActivityLevelModel(titleKey: 'calorie_calculator.activity.light', iconAsset: AppIcons.light, iconSize: Size(13, 21.5)),
    ActivityLevelModel(titleKey: 'calorie_calculator.activity.moderate', iconAsset: AppIcons.moderate, iconSize: Size(19.8, 19.8)),
    ActivityLevelModel(titleKey: 'calorie_calculator.activity.active', icon: AppIcons.active, iconSize: Size(22, 22)),
    ActivityLevelModel(titleKey: 'calorie_calculator.activity.very_active', icon: AppIcons.veryActive, iconSize: Size(22, 22)),
  ];
}

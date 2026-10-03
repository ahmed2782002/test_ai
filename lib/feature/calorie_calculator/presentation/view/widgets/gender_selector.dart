import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../view_model/calorie_calculator_state.dart';
import 'gender_option.dart';

class GenderSelector extends StatelessWidget {
  final Gender selected;
  final ValueChanged<Gender> onSelect;

  const GenderSelector({super.key, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 74.w,
          child: Text('calorie_calculator.gender'.tr(context: context), style: AppText.label),
        ),
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GenderOption(
                  label: 'calorie_calculator.male'.tr(context: context),
                  icon: AppIcons.male,
                  isSelected: selected == Gender.male,
                  onTap: () => onSelect(Gender.male),
                ),
                SizedBox(width: 9.w),
                GenderOption(
                  label: 'calorie_calculator.female'.tr(context: context),
                  icon: AppIcons.female,
                  isSelected: selected == Gender.female,
                  onTap: () => onSelect(Gender.female),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

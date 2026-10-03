import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_icons.dart';
import 'counter_action_button.dart';

class CounterFieldRow extends StatelessWidget {
  final String label;
  final String unit;
  final int value;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CounterFieldRow({
    super.key,
    required this.label,
    required this.unit,
    required this.value,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 74.w,
          child: Text.rich(
            TextSpan(
              text: label,
              style: AppText.label,
              children: [TextSpan(text: unit, style: AppText.unit)],
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 42.h,
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            decoration: BoxDecoration(
              color: AppColors.fieldBackground,
              borderRadius: BorderRadius.circular(AppRadius.small),
              border: Border.all(color: AppColors.fieldBorder),
            ),
            child: Row(
              children: [
                CounterActionButton(icon: AppIcons.plus, onTap: onIncrease),
                Expanded(
                  child: Text('$value', textAlign: TextAlign.center, style: AppText.counterValue),
                ),
                CounterActionButton(icon: AppIcons.minus, onTap: onDecrease),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

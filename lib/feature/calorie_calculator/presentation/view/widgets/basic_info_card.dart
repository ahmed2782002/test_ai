import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/widgets/app_svg_icon/app_svg_icon.dart';
import '../../view_model/calorie_calculator_cubit.dart';
import '../../view_model/calorie_calculator_state.dart';
import 'counter_field_row.dart';
import 'gender_selector.dart';

class BasicInfoCard extends StatelessWidget {
  final CalorieCalculatorState state;

  const BasicInfoCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CalorieCalculatorCubit>();
    final fields = [
      GenderSelector(selected: state.gender, onSelect: cubit.selectGender),
      CounterFieldRow(
        label: 'calorie_calculator.weight'.tr(context: context),
        unit: 'calorie_calculator.kg'.tr(context: context),
        value: state.weight,
        onIncrease: cubit.increaseWeight,
        onDecrease: cubit.decreaseWeight,
      ),
      CounterFieldRow(
        label: 'calorie_calculator.height'.tr(context: context),
        unit: 'calorie_calculator.cm'.tr(context: context),
        value: state.height,
        onIncrease: cubit.increaseHeight,
        onDecrease: cubit.decreaseHeight,
      ),
      CounterFieldRow(
        label: 'calorie_calculator.age'.tr(context: context),
        unit: 'calorie_calculator.year'.tr(context: context),
        value: state.age,
        onIncrease: cubit.increaseAge,
        onDecrease: cubit.decreaseAge,
      ),
    ];
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.large),
        boxShadow: AppShadows.infoCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              AppSvgIcon(asset: AppIcons.user, width: 20.r, height: 20.r),
              SizedBox(width: 8.w),
              Expanded(
                child: Text('calorie_calculator.basic_info'.tr(context: context), style: AppText.cardTitle),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          const Divider(height: 1, thickness: 1, color: AppColors.fieldBorder),
          for (final field in fields) ...[SizedBox(height: 20.h), field],
        ],
      ),
    );
  }
}

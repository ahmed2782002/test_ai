import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text.dart';
import '../../view_model/calorie_calculator_cubit.dart';
import 'goal_card.dart';

class GoalSection extends StatelessWidget {
  final int selectedIndex;

  const GoalSection({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CalorieCalculatorCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('calorie_calculator.goal_title'.tr(context: context), style: AppText.sectionTitle),
          SizedBox(height: 20.h),
          for (var index = 0; index < cubit.goals.length; index++)
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: GoalCard(
                goal: cubit.goals[index],
                isSelected: selectedIndex == index,
                onTap: () => cubit.selectGoal(index),
              ),
            ),
        ],
      ),
    );
  }
}

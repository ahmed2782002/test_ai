import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text.dart';
import '../../view_model/calorie_calculator_cubit.dart';
import 'activity_level_card.dart';

class ActivityLevelSection extends StatelessWidget {
  final int selectedIndex;

  const ActivityLevelSection({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CalorieCalculatorCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text('calorie_calculator.activity_level'.tr(context: context), style: AppText.sectionTitle),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 108.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            itemCount: cubit.activityLevels.length,
            separatorBuilder: (_, _) => SizedBox(width: 12.w),
            itemBuilder: (context, index) => ActivityLevelCard(
              level: cubit.activityLevels[index],
              isSelected: selectedIndex == index,
              onTap: () => cubit.selectActivity(index),
            ),
          ),
        ),
      ],
    );
  }
}

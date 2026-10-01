import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/widgets/app_header/app_header.dart';
import '../../../../calorie_results/presentation/view/screen/calorie_results_screen.dart';
import '../../../../calorie_results/presentation/view_model/calorie_results_cubit.dart';
import '../../../mock_model/gender.dart';
import '../../view_model/calorie_calculator_cubit.dart';
import '../../view_model/calorie_calculator_state.dart';
import '../widgets/activity_level_card.dart';
import '../widgets/calculate_bottom_bar.dart';
import '../widgets/counter_field.dart';
import '../widgets/gender_option.dart';
import '../widgets/goal_card.dart';
import '../widgets/info_section_card.dart';
import '../widgets/labeled_field_row.dart';

class CalorieCalculatorScreen extends StatelessWidget {
  const CalorieCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CalorieCalculatorCubit>();
    return BlocListener<CalorieCalculatorCubit, CalorieCalculatorState>(
      listenWhen: (previous, current) =>
          current.status == CalorieCalculatorStatus.submitted,
      listener: (context, state) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => CalorieResultsCubit()..load(),
            child: const CalorieResultsScreen(),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        bottomNavigationBar: CalculateBottomBar(
          buttonText: 'calorie_calculator.calculate'.tr(context: context),
          hint: 'calorie_calculator.hint'.tr(context: context),
          onPressed: cubit.calculate,
        ),
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<CalorieCalculatorCubit, CalorieCalculatorState>(
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(height: 8.h),
                  AppHeader(
                    title: 'calorie_calculator.title'.tr(context: context),
                    onBack: () => Navigator.maybePop(context),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Text(
                              'calorie_calculator.subtitle'.tr(
                                context: context,
                              ),
                              textAlign: TextAlign.center,
                              style: AppText.subtitle,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: InfoSectionCard(
                              title: 'calorie_calculator.basic_info'.tr(
                                context: context,
                              ),
                              icon: AppIcons.user,
                              children: [
                                LabeledFieldRow(
                                  label: 'calorie_calculator.gender'.tr(
                                    context: context,
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GenderOption(
                                          label: 'calorie_calculator.male'.tr(
                                            context: context,
                                          ),
                                          icon: AppIcons.male,
                                          isSelected: cubit.isGenderSelected(
                                            Gender.male,
                                          ),
                                          onTap: () =>
                                              cubit.selectGender(Gender.male),
                                        ),
                                        SizedBox(width: 9.w),
                                        GenderOption(
                                          label: 'calorie_calculator.female'.tr(
                                            context: context,
                                          ),
                                          icon: AppIcons.female,
                                          isSelected: cubit.isGenderSelected(
                                            Gender.female,
                                          ),
                                          onTap: () =>
                                              cubit.selectGender(Gender.female),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                LabeledFieldRow(
                                  label: 'calorie_calculator.weight'.tr(
                                    context: context,
                                  ),
                                  unit: 'calorie_calculator.kg'.tr(
                                    context: context,
                                  ),
                                  child: CounterField(
                                    value: state.weight,
                                    onIncrease: cubit.increaseWeight,
                                    onDecrease: cubit.decreaseWeight,
                                  ),
                                ),
                                LabeledFieldRow(
                                  label: 'calorie_calculator.height'.tr(
                                    context: context,
                                  ),
                                  unit: 'calorie_calculator.cm'.tr(
                                    context: context,
                                  ),
                                  child: CounterField(
                                    value: state.height,
                                    onIncrease: cubit.increaseHeight,
                                    onDecrease: cubit.decreaseHeight,
                                  ),
                                ),
                                LabeledFieldRow(
                                  label: 'calorie_calculator.age'.tr(
                                    context: context,
                                  ),
                                  unit: 'calorie_calculator.year'.tr(
                                    context: context,
                                  ),
                                  child: CounterField(
                                    value: state.age,
                                    onIncrease: cubit.increaseAge,
                                    onDecrease: cubit.decreaseAge,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Text(
                              'calorie_calculator.activity_level'.tr(
                                context: context,
                              ),
                              style: AppText.sectionTitle,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          SizedBox(
                            height: 108.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 17.w),
                              itemCount: cubit.activityLevels.length,
                              separatorBuilder: (_, _) => SizedBox(width: 12.w),
                              itemBuilder: (context, index) {
                                final level = cubit.activityLevels[index];
                                return ActivityLevelCard(
                                  title: level.titleKey.tr(context: context),
                                  iconAsset: level.iconAsset,
                                  icon: level.icon,
                                  iconSize: level.iconSize,
                                  isSelected: cubit.isActivitySelected(index),
                                  onTap: () => cubit.selectActivity(index),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 28.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Text(
                              'calorie_calculator.goal_title'.tr(
                                context: context,
                              ),
                              style: AppText.sectionTitle,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          for (
                            var index = 0;
                            index < cubit.goals.length;
                            index++
                          )
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                start: 20.w,
                                end: 20.w,
                                bottom: 16.h,
                              ),
                              child: GoalCard(
                                title: cubit.goals[index].titleKey.tr(
                                  context: context,
                                ),
                                icon: cubit.goals[index].icon,
                                iconSize: cubit.goals[index].iconSize,
                                iconColor: cubit.goals[index].iconColor,
                                iconBackground:
                                    cubit.goals[index].iconBackground,
                                isSelected: cubit.isGoalSelected(index),
                                onTap: () => cubit.selectGoal(index),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

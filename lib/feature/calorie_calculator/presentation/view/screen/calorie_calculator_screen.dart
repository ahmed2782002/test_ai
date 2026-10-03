import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/widgets/app_header/app_header.dart';
import '../../../../calorie_results/presentation/view/screen/calorie_results_screen.dart';
import '../../../../calorie_results/presentation/view_model/calorie_results_cubit.dart';
import '../../view_model/calorie_calculator_cubit.dart';
import '../../view_model/calorie_calculator_state.dart';
import '../widgets/activity_level_section.dart';
import '../widgets/basic_info_card.dart';
import '../widgets/calculate_bottom_bar.dart';
import '../widgets/goal_section.dart';

class CalorieCalculatorScreen extends StatelessWidget {
  const CalorieCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CalorieCalculatorCubit>();
    return BlocListener<CalorieCalculatorCubit, CalorieCalculatorState>(
      listenWhen: (previous, current) => current.status == CalorieCalculatorStatus.submitted,
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
                              'calorie_calculator.subtitle'.tr(context: context),
                              textAlign: TextAlign.center,
                              style: AppText.subtitle,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: BasicInfoCard(state: state),
                          ),
                          SizedBox(height: 20.h),
                          ActivityLevelSection(selectedIndex: state.activityIndex),
                          SizedBox(height: 28.h),
                          GoalSection(selectedIndex: state.goalIndex),
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

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_ui/feature/layout/presentation/view/screen/layout_screen.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/widgets/app_header/app_header.dart';
import '../../view_model/calorie_results_cubit.dart';
import '../../view_model/calorie_results_state.dart';
import '../widgets/calorie_results_error_view.dart';
import '../widgets/calorie_results_shimmer.dart';
import '../widgets/daily_need_card.dart';
import '../widgets/macro_nutrient_card.dart';
import '../widgets/package_card.dart';
import '../widgets/package_feature_row.dart';
import '../widgets/packages_section_header.dart';

class CalorieResultsScreen extends StatelessWidget {
  const CalorieResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CalorieResultsCubit>();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            AppHeader(
              title: 'calorie_results.title'.tr(context: context),
              onBack: () => Navigator.maybePop(context),
            ),
            Expanded(
              child: BlocBuilder<CalorieResultsCubit, CalorieResultsState>(
                builder: (context, state) {
                  final results = state.results;
                  if (state.status == CalorieResultsStatus.loading) {
                    return const CalorieResultsShimmer();
                  }
                  if (state.status == CalorieResultsStatus.failure || results == null) {
                    return CalorieResultsErrorView(
                      message: 'calorie_results.error'.tr(context: context),
                      retryText: 'calorie_results.retry'.tr(context: context),
                      onRetry: cubit.load,
                    );
                  }
                  return SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(17.w, 10.h, 17.w, 32.h + MediaQuery.paddingOf(context).bottom),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'calorie_results.subtitle'.tr(context: context),
                          style: AppText.subtitle,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20.h),
                        DailyNeedCard(
                          title: 'calorie_results.daily_need'.tr(context: context),
                          value: cubit.formattedDailyCalories,
                          unit: 'calorie_results.kcal'.tr(context: context),
                        ),
                        SizedBox(height: 20.h),
                        Text('calorie_results.macros'.tr(context: context), style: AppText.sectionTitle),
                        SizedBox(height: 14.h),
                        for (final macro in results.macros) ...[
                          MacroNutrientCard(
                            icon: macro.type.icon,
                            iconSize: macro.type.iconSize,
                            color: macro.type.color,
                            lightColor: macro.type.lightColor,
                            name: macro.type.labelKey.tr(context: context),
                            value: '${macro.grams}${'calorie_results.gram'.tr(context: context)}',
                            progress: macro.progress,
                          ),
                          SizedBox(height: 12.h),
                        ],
                        SizedBox(height: 12.h),
                        PackagesSectionHeader(
                          title: 'calorie_results.packages_title'.tr(context: context),
                          actionText: 'calorie_results.view_all'.tr(context: context),
                          onAction: () {},
                        ),
                        SizedBox(height: 18.h),
                        for (final package in results.packages) ...[
                          PackageCard(
                            image: package.image,
                            name: package.name.tr(context: context),
                            description: package.description.tr(context: context),
                            price: '${package.monthlyPrice}',
                            currency: 'calorie_results.currency'.tr(context: context),
                            period: 'calorie_results.per_month'.tr(context: context),
                            badgeText: package.fitsGoal ? 'calorie_results.fits_goal'.tr(context: context) : null,
                            features: [
                              for (final feature in package.features)
                                PackageFeatureRow(icon: feature.icon, iconSize: feature.iconSize, title: feature.title.tr(context: context)),
                            ],
                            actionText: 'calorie_results.subscribe'.tr(context: context),
                            onAction: () => Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (_) => const LayoutScreen()),
                              (route) => false,
                            ),
                          ),
                          SizedBox(height: 16.h),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

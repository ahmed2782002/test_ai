import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../spin_wheel/presentation/view/screen/spin_wheel_screen.dart';
import '../../view_model/home_cubit.dart';
import '../../view_model/home_state.dart';
import '../widgets/health_tip_card.dart';
import '../widgets/home_banner_slider.dart';
import '../widgets/home_error_view.dart';
import '../widgets/home_header.dart';
import '../widgets/home_search_field.dart';
import '../widgets/home_shimmer.dart';
import '../widgets/packages_section.dart';
import '../widgets/quick_actions_list.dart';
import '../widgets/steps_card.dart';
import '../widgets/suggested_meal_card.dart';

class HomeScreen extends StatelessWidget {
  final double bottomSpacing;

  const HomeScreen({super.key, required this.bottomSpacing});

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.only(top: MediaQuery.paddingOf(context).top + 20.h, bottom: bottomSpacing + 24.h);
    return BlocProvider(
      create: (context) => HomeCubit()..loadHome(),
      child: ColoredBox(
        color: AppColors.neutralBackground,
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final cubit = context.read<HomeCubit>();
            final home = state.home;
            if (state.status == HomeStatus.loading) return HomeShimmer(padding: padding);
            if (state.status == HomeStatus.error || home == null) return HomeErrorView(onRetry: cubit.loadHome);
            final languageCode = context.locale.languageCode;
            return ListView(
              padding: padding,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: HomeHeader(
                    name: home.user.name.of(languageCode),
                    avatar: home.user.avatar,
                    hasUnreadNotifications: home.user.hasUnreadNotifications,
                    onNotificationTap: () {},
                  ),
                ),
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: HomeSearchField(controller: cubit.searchController, hint: context.tr('home.search_hint')),
                ),
                SizedBox(height: 22.h),
                HomeBannerSlider(
                  banners: home.banners,
                  controller: cubit.bannerController,
                  onBannerTap: (banner) => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SpinWheelScreen()),
                  ),
                ),
                SizedBox(height: 20.h),
                QuickActionsList(actions: cubit.quickActions, onActionTap: (action) {}),
                SizedBox(height: 18.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: SuggestedMealCard(meal: home.mealOfTheDay, onViewMeal: () {}),
                ),
                SizedBox(height: 26.h),
                PackagesSection(
                  title: context.tr('home.suitable_packages'),
                  titleStyle: AppText.packagesTitle,
                  packages: home.suitablePackages,
                  onViewAll: () {},
                  onPackageTap: (package) {},
                ),
                PackagesSection(
                  title: context.tr('home.most_ordered'),
                  packages: home.mostOrderedPackages,
                  onViewAll: () {},
                  onPackageTap: (package) {},
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: StepsCard(steps: home.steps, weeklyFactors: cubit.weeklyStepsFactors, onTap: () {}),
                ),
                SizedBox(height: 22.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: HealthTipCard(
                    title: context.tr('home.health_tip_title'),
                    body: home.healthTip.body.of(languageCode),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/widgets/nav_bar_app/nav_bar_app.dart';
import '../../../../../core/widgets/nav_bar_app/nav_bar_item_data.dart';
import '../../../../home/presentation/view/screen/home_screen.dart';
import '../../view_model/layout_cubit.dart';
import '../../view_model/layout_state.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navBarHeight = 100.h + MediaQuery.paddingOf(context).bottom;
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) => Scaffold(
          backgroundColor: AppColors.neutralBackground,
          extendBody: true,
          body: IndexedStack(
            index: state.currentIndex == LayoutCubit.homeIndex ? 0 : 1,
            children: [
              HomeScreen(bottomSpacing: navBarHeight),
              const SizedBox.shrink(),
            ],
          ),
          bottomNavigationBar: NavBarApp(
            currentIndex: state.currentIndex,
            onTap: context.read<LayoutCubit>().selectTab,
            items: [
              NavBarItemData(icon: AppIcons.navHome, iconHeight: 18.72, label: context.tr('nav_bar.home')),
              NavBarItemData(icon: AppIcons.navOrders, iconHeight: 24.96, label: context.tr('nav_bar.my_orders')),
              NavBarItemData(icon: AppIcons.navCalories, iconHeight: 19.8, label: context.tr('nav_bar.calories')),
              NavBarItemData(icon: AppIcons.navMeals, iconHeight: 20.8, label: context.tr('nav_bar.meals')),
              NavBarItemData(icon: AppIcons.navAccount, iconHeight: 24.96, label: context.tr('nav_bar.account')),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_ui/core/utils/app_icons.dart';
import 'package:test_ui/core/utils/app_images.dart';
import 'package:test_ui/core/utils/localized_text.dart';
import 'package:test_ui/core/widgets/app_error_view/app_error_view.dart';
import 'package:test_ui/core/widgets/app_svg_icon/app_svg_icon.dart';
import 'package:test_ui/feature/home/mock_model/home_model.dart';
import 'package:test_ui/feature/home/mock_model/package_model.dart';
import 'package:test_ui/feature/home/presentation/view/widgets/home_banner_actions.dart';
import 'package:test_ui/feature/home/presentation/view/widgets/home_header.dart';
import 'package:test_ui/feature/home/presentation/view/widgets/packages_section.dart';
import 'package:test_ui/feature/home/presentation/view/widgets/steps_card.dart';
import 'package:test_ui/feature/home/presentation/view/widgets/suggested_meal_card.dart';

import '../../../../../helpers/pump_app.dart';

final _muscle = HomeModel.mock.suitablePackages[0];
final _keto = HomeModel.mock.suitablePackages[1];

const _singleMealPackage = PackageModel(
  id: 99,
  name: LocalizedText(ar: 'باقة تجربة', en: 'Trial Package'),
  image: AppImages.testPackageKeto,
  period: PackagePeriod.weekly,
  mealsPerDay: 1,
  price: 1500,
);

void main() {
  group('HomeHeader', () {
    testWidgets('greets the user by name', (tester) async {
      await tester.pumpApp(
        HomeHeader(name: 'Sara', avatar: HomeModel.mock.userAvatar, hasUnreadNotifications: false, onNotificationTap: () {}),
      );

      expect(find.text('Hello, Sara'), findsOneWidget);
      expect(find.text('Ready for a new healthy day?'), findsOneWidget);
    });

    testWidgets('calls onNotificationTap when the bell is tapped', (tester) async {
      var taps = 0;
      await tester.pumpApp(
        HomeHeader(name: 'Sara', avatar: HomeModel.mock.userAvatar, hasUnreadNotifications: true, onNotificationTap: () => taps++),
      );

      await tester.tap(find.byWidgetPredicate((widget) => widget is AppSvgIcon && widget.asset == AppIcons.notification));
      await tester.pump();

      expect(taps, 1);
    });

    testWidgets('truncates a very long name instead of overflowing', (tester) async {
      await tester.pumpApp(
        HomeHeader(name: 'Abdelrahman ' * 10, avatar: HomeModel.mock.userAvatar, hasUnreadNotifications: false, onNotificationTap: () {}),
      );

      expect(tester.takeException(), isNull);
    });
  });

  group('AppErrorView', () {
    testWidgets('shows the message and retries on tap', (tester) async {
      var retries = 0;
      await tester.pumpApp(
        AppErrorView(message: 'Something went wrong, please try again', retryText: 'Retry', onRetry: () => retries++),
      );

      expect(find.text('Something went wrong, please try again'), findsOneWidget);

      await tester.tap(find.text('Retry'));
      await tester.pump();

      expect(retries, 1);
    });
  });

  group('PackagesSection', () {
    Widget section(List<PackageModel> packages, {VoidCallback? onViewAll, ValueChanged<PackageModel>? onPackageTap}) {
      return PackagesSection(
        title: 'Most ordered',
        packages: packages,
        onViewAll: onViewAll ?? () {},
        onPackageTap: onPackageTap ?? (_) {},
      );
    }

    testWidgets('shows the title and calls onViewAll', (tester) async {
      var taps = 0;
      await tester.pumpApp(section(const [], onViewAll: () => taps++));

      expect(find.text('Most ordered'), findsOneWidget);

      await tester.tap(find.text('View all'));
      await tester.pump();

      expect(taps, 1);
    });

    testWidgets('shows name, period, meals per day and price', (tester) async {
      await tester.pumpApp(section([_muscle]));

      expect(find.text('Muscle Building Package'), findsOneWidget);
      expect(find.text('Monthly / 3 meals a day'), findsOneWidget);
      expect(find.text('899 SAR'), findsOneWidget);
    });

    testWidgets('uses the singular form for one meal a day and formats thousands', (tester) async {
      await tester.pumpApp(section(const [_singleMealPackage]));

      expect(find.text('Weekly / 1 meal a day'), findsOneWidget);
      expect(find.text('1,500 SAR'), findsOneWidget);
    });

    testWidgets('shows the Arabic name and Arabic digits', (tester) async {
      await tester.pumpApp(section([_muscle]), locale: ar);

      expect(find.text('باقة بناء العضلات'), findsOneWidget);
      expect(find.textContaining('٨٩٩'), findsOneWidget);
    });

    testWidgets('passes the tapped package to onPackageTap', (tester) async {
      PackageModel? tapped;
      await tester.pumpApp(section([_muscle, _keto], onPackageTap: (package) => tapped = package));

      await tester.tap(find.text('Healthy Keto Package'));
      await tester.pump();

      expect(tapped?.id, _keto.id);
    });
  });

  group('HomeBannerActions', () {
    testWidgets('passes the tapped action and banner index to the callbacks', (tester) async {
      final controller = PageController();
      addTearDown(controller.dispose);
      QuickActionType? tappedAction;
      int? tappedBanner;
      await tester.pumpApp(
        HomeBannerActions(
          banners: HomeModel.mock.banners,
          bannerController: controller,
          actions: QuickActionType.values,
          onBannerTap: (index) => tappedBanner = index,
          onActionTap: (action) => tappedAction = action,
        ),
      );

      await tester.tap(find.text('Packages'));
      await tester.tap(find.byType(PageView));
      await tester.pump();

      expect(tappedAction, QuickActionType.packages);
      expect(tappedBanner, 0);
    });
  });

  group('SuggestedMealCard', () {
    testWidgets('shows the meal and calls onViewMeal', (tester) async {
      var taps = 0;
      await tester.pumpApp(
        SingleChildScrollView(child: SuggestedMealCard(home: HomeModel.mock, onViewMeal: () => taps++)),
      );

      expect(find.text('Grilled Chicken with Brown Rice'), findsOneWidget);
      expect(find.text('480 kcal'), findsOneWidget);
      expect(find.text('42 g protein'), findsOneWidget);

      await tester.tap(find.text('View meal'));
      await tester.pump();

      expect(taps, 1);
    });
  });

  group('StepsCard', () {
    testWidgets('shows today steps and goal, and calls onTap', (tester) async {
      var taps = 0;
      await tester.pumpApp(
        StepsCard(
          todaySteps: 1234,
          goal: 8000,
          weeklyFactors: const [0.8, 1],
          onTap: () => taps++,
        ),
      );

      expect(find.text('1,234 steps today'), findsOneWidget);
      expect(find.text('Goal: 8,000 steps'), findsOneWidget);

      await tester.tap(find.byType(StepsCard));
      await tester.pump();

      expect(taps, 1);
    });
  });
}

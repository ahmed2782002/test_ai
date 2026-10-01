import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_ui/feature/home/presentation/view/screen/home_screen.dart';
import 'package:test_ui/feature/home/presentation/view/widgets/home_banner_slider.dart';
import 'package:test_ui/feature/home/presentation/view/widgets/home_header.dart';
import 'package:test_ui/feature/home/presentation/view/widgets/home_shimmer.dart';
import 'package:test_ui/feature/spin_wheel/presentation/view/screen/spin_wheel_screen.dart';

import '../../../../../helpers/pump_app.dart';

/// `HomeMockData.fetchHome` waits 900 ms before returning the data.
const Duration _homeLoadTime = Duration(milliseconds: 900);

void main() {
  /// HomeScreen creates its own cubit, so these tests run the real cubit with the mock data.
  Future<void> pumpHome(WidgetTester tester, {Locale locale = en}) async {
    await tester.pumpApp(const HomeScreen(bottomSpacing: 0), locale: locale);
  }

  Future<void> pumpLoadedHome(WidgetTester tester, {Locale locale = en}) async {
    await pumpHome(tester, locale: locale);
    await tester.pump(_homeLoadTime);
    await tester.pump();
  }

  Future<void> scrollTo(WidgetTester tester, Finder finder) {
    return tester.scrollUntilVisible(finder, 300, scrollable: find.byType(Scrollable).first);
  }

  group('HomeScreen states', () {
    testWidgets('shows shimmer while loading', (tester) async {
      await pumpHome(tester);

      expect(find.byType(HomeShimmer), findsOneWidget);
      expect(find.byType(HomeHeader), findsNothing);

      await tester.pump(_homeLoadTime); // let the pending load finish cleanly
    });

    testWidgets('replaces the shimmer with content once loaded', (tester) async {
      await pumpLoadedHome(tester);

      expect(find.byType(HomeShimmer), findsNothing);
      expect(find.text('Hello, Ahmed'), findsOneWidget);
      expect(find.text('Ready for a new healthy day?'), findsOneWidget);
    });
  });

  group('HomeScreen content', () {
    testWidgets('shows search hint and quick actions', (tester) async {
      await pumpLoadedHome(tester);

      expect(find.text('Search for a meal or package...'), findsOneWidget);
      for (final label in ['My steps', 'Packages', 'Subscription', 'My orders', 'Order meal']) {
        expect(find.text(label), findsOneWidget, reason: label);
      }
    });

    testWidgets('shows the meal of the day with its nutrients', (tester) async {
      await pumpLoadedHome(tester);
      await scrollTo(tester, find.text('View meal'));

      expect(find.text('Suggested meal of the day'), findsOneWidget);
      expect(find.text('Grilled Chicken with Brown Rice'), findsOneWidget);
      expect(find.text('480 kcal'), findsOneWidget);
      expect(find.text('42 g protein'), findsOneWidget);
    });

    testWidgets('shows both package sections', (tester) async {
      await pumpLoadedHome(tester);

      await scrollTo(tester, find.text('Packages for you'));
      expect(find.text('Packages for you'), findsOneWidget);

      await scrollTo(tester, find.text('Most ordered'));
      expect(find.text('Most ordered'), findsOneWidget);
      expect(find.text('Muscle Building Package'), findsWidgets);
      expect(find.text('Healthy Keto Package'), findsWidgets);
    });

    testWidgets('shows steps progress and the health tip', (tester) async {
      await pumpLoadedHome(tester);

      await scrollTo(tester, find.text("Today's health tip"));

      expect(find.text('6,420 steps today'), findsOneWidget);
      expect(find.text('Goal: 10,000 steps'), findsOneWidget);
      expect(find.text('Start your meal with vegetables to feel fuller and absorb fiber better.'), findsOneWidget);
    });
  });

  group('HomeScreen interactions', () {
    testWidgets('accepts text in the search field', (tester) async {
      await pumpLoadedHome(tester);

      await tester.enterText(find.byType(TextField), 'chicken');
      await tester.pump();

      expect(find.text('chicken'), findsOneWidget);
    });

    testWidgets('opens the spin wheel when tapping a banner', (tester) async {
      await pumpLoadedHome(tester);

      await tester.tap(find.byType(HomeBannerSlider));
      await tester.pumpAndSettle();

      expect(find.byType(SpinWheelScreen), findsOneWidget);
      expect(find.text('Your gift is waiting!'), findsOneWidget);
    });
  });

  group('HomeScreen localization', () {
    testWidgets('shows Arabic greeting and Arabic digits', (tester) async {
      await pumpLoadedHome(tester, locale: ar);

      expect(find.text('مرحبًا أحمد'), findsOneWidget);

      await scrollTo(tester, find.textContaining('٨٩٩'));
      expect(find.textContaining('٨٩٩'), findsWidgets);
    });
  });
}

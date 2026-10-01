import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_ui/core/widgets/nav_bar_app/nav_bar_app.dart';
import 'package:test_ui/core/widgets/nav_bar_app/nav_bar_center_button_app.dart';
import 'package:test_ui/feature/home/presentation/view/widgets/home_header.dart';
import 'package:test_ui/feature/layout/presentation/view/screen/layout_screen.dart';

import '../../../../../helpers/pump_app.dart';

Finder _navLabel(String label) => find.descendant(of: find.byType(NavBarApp), matching: find.text(label));

void main() {
  Future<void> pumpLayout(WidgetTester tester, {Locale locale = en}) async {
    await tester.pumpApp(const LayoutScreen(), wrapInScaffold: false, locale: locale);
    await tester.pump(const Duration(seconds: 1)); // home data loads after 900 ms
  }

  group('LayoutScreen', () {
    testWidgets('opens on the home tab', (tester) async {
      await pumpLayout(tester);

      expect(find.byType(HomeHeader), findsOneWidget);
    });

    testWidgets('shows all five tabs in the bottom bar', (tester) async {
      await pumpLayout(tester);

      for (final label in ['Home', 'My orders', 'Calories', 'Meals', 'Account']) {
        expect(_navLabel(label), findsOneWidget, reason: label);
      }
    });

    testWidgets('hides home when another tab is selected', (tester) async {
      await pumpLayout(tester);

      await tester.tap(_navLabel('My orders'));
      await tester.pump();

      expect(find.byType(HomeHeader), findsNothing);
    });

    testWidgets('returns to home when the home tab is tapped again', (tester) async {
      await pumpLayout(tester);

      await tester.tap(_navLabel('Account'));
      await tester.pump();
      await tester.tap(_navLabel('Home'));
      await tester.pump();

      expect(find.byType(HomeHeader), findsOneWidget);
      expect(find.text('Hello, Ahmed'), findsOneWidget); // state kept, no reload
    });

    testWidgets('switches tab from the raised center button', (tester) async {
      await pumpLayout(tester);

      await tester.tap(find.byType(NavBarCenterButtonApp));
      await tester.pump();

      expect(find.byType(HomeHeader), findsNothing);
    });

    testWidgets('shows Arabic tab labels', (tester) async {
      await pumpLayout(tester, locale: ar);

      expect(_navLabel('الرئيسية'), findsOneWidget);
      expect(_navLabel('طلباتي'), findsOneWidget);
    });
  });
}

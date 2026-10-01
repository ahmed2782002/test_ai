import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_ui/core/widgets/app_header/app_header.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('AppHeader', () {
    testWidgets('shows the title', (tester) async {
      await tester.pumpApp(const AppHeader(title: 'Calorie Calculator'));

      expect(find.text('Calorie Calculator'), findsOneWidget);
    });

    testWidgets('hides the back button when onBack is null', (tester) async {
      await tester.pumpApp(const AppHeader(title: 'Title'));

      expect(find.byType(IconButton), findsNothing);
    });

    testWidgets('calls onBack when the back button is tapped', (tester) async {
      var backTaps = 0;
      await tester.pumpApp(AppHeader(title: 'Title', onBack: () => backTaps++));

      await tester.tap(find.byType(IconButton));
      await tester.pump();

      expect(backTaps, 1);
    });

    testWidgets('truncates a very long title instead of overflowing', (tester) async {
      await tester.pumpApp(AppHeader(title: 'Very long title ' * 20, onBack: () {}));

      expect(tester.takeException(), isNull);
    });

    testWidgets('puts the back button on the right in Arabic', (tester) async {
      await tester.pumpApp(AppHeader(title: 'عنوان', onBack: () {}), locale: ar);

      final screenCenter = tester.getCenter(find.byType(AppHeader)).dx;
      expect(tester.getCenter(find.byType(IconButton)).dx, greaterThan(screenCenter));
    });
  });
}

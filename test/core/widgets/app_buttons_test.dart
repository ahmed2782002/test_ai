import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_ui/core/widgets/app_outlined_button/app_outlined_button.dart';
import 'package:test_ui/core/widgets/app_primary_button/app_primary_button.dart';

import '../../helpers/pump_app.dart';

/// Runs [body] with semantics enabled.
///
/// The handle must be disposed before the test body ends: flutter_test checks for
/// active handles before `addTearDown` callbacks run, so dispose it in `finally`.
Future<void> _withSemantics(WidgetTester tester, Future<void> Function() body) async {
  final handle = tester.ensureSemantics();
  try {
    await body();
  } finally {
    handle.dispose();
  }
}

void main() {
  group('AppPrimaryButton', () {
    testWidgets('shows its text and calls onPressed when tapped', (tester) async {
      var taps = 0;
      await tester.pumpApp(AppPrimaryButton(text: 'Save', onPressed: () => taps++));

      await tester.tap(find.text('Save'));
      await tester.pump();

      expect(taps, 1);
    });

    testWidgets('shows the trailing icon when provided', (tester) async {
      await tester.pumpApp(AppPrimaryButton(text: 'Next', trailingIcon: Icons.arrow_forward, onPressed: () {}));

      expect(find.text('Next'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('is announced as a disabled button without onPressed', (tester) async {
      await _withSemantics(tester, () async {
        await tester.pumpApp(const AppPrimaryButton(text: 'Save'));

        expect(
          tester.getSemantics(find.bySemanticsLabel('Save')),
          isSemantics(label: 'Save', isButton: true, hasEnabledState: true, isEnabled: false),
        );
      });
    });

    testWidgets('is announced as an enabled button with onPressed', (tester) async {
      await _withSemantics(tester, () async {
        await tester.pumpApp(AppPrimaryButton(text: 'Save', onPressed: () {}));

        expect(
          tester.getSemantics(find.bySemanticsLabel('Save')),
          isSemantics(label: 'Save', isButton: true, isEnabled: true),
        );
      });
    });
  });

  group('AppOutlinedButton', () {
    testWidgets('shows its text and calls onPressed when tapped', (tester) async {
      var taps = 0;
      await tester.pumpApp(AppOutlinedButton(text: 'Later', onPressed: () => taps++));

      await tester.tap(find.text('Later'));
      await tester.pump();

      expect(taps, 1);
    });

    testWidgets('is announced as disabled without onPressed', (tester) async {
      await _withSemantics(tester, () async {
        await tester.pumpApp(const AppOutlinedButton(text: 'Later'));

        expect(
          tester.getSemantics(find.bySemanticsLabel('Later')),
          isSemantics(isButton: true, hasEnabledState: true, isEnabled: false),
        );
      });
    });
  });
}

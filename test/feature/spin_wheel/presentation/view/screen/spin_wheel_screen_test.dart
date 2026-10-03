import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_ui/feature/spin_wheel/presentation/view/screen/spin_wheel_screen.dart';
import 'package:test_ui/feature/spin_wheel/presentation/view/widgets/spin_wheel/spin_wheel.dart';
import 'package:test_ui/feature/spin_wheel/presentation/view/widgets/spin_wheel/spin_wheel_label.dart';
import 'package:test_ui/feature/spin_wheel/presentation/view_model/spin_wheel_cubit.dart';

import '../../../../../helpers/pump_app.dart';

void main() {
  /// Lets the wheel animation run to the end and the result snackbar slide in.
  Future<void> finishSpin(WidgetTester tester) async {
    await tester.pump();
    await tester.pump(SpinWheelCubit.spinDuration);
    await tester.pump(); // onEnd -> cubit emits "won" -> listener shows the snackbar
    await tester.pump(const Duration(milliseconds: 300)); // snackbar entrance
  }

  Future<void> pumpScreen(WidgetTester tester, {Locale locale = en}) {
    return tester.pumpApp(const SpinWheelScreen(), wrapInScaffold: false, locale: locale);
  }

  group('SpinWheelScreen content', () {
    testWidgets('shows title, subtitle and both actions', (tester) async {
      await pumpScreen(tester);

      expect(find.text('Your gift is waiting!'), findsOneWidget);
      expect(find.text('Spin the wheel and discover your prize'), findsOneWidget);
      expect(find.text('Spin the wheel now'), findsOneWidget);
      expect(find.text('Use later'), findsOneWidget);
    });

    testWidgets('shows all eight prizes on the wheel', (tester) async {
      await pumpScreen(tester);

      expect(find.byType(SpinWheelLabel), findsNWidgets(8));
      expect(find.text('Free\nmeal'), findsOneWidget);
      expect(find.text('20%\noff'), findsOneWidget);
    });
  });

  group('SpinWheelScreen spinning', () {
    testWidgets('announces the prize after spinning from the button', (tester) async {
      await pumpScreen(tester);

      await tester.tap(find.text('Spin the wheel now'));
      await finishSpin(tester);

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.textContaining('Congrats! You won'), findsOneWidget);
    });

    testWidgets('announces the prize after tapping the wheel hub', (tester) async {
      await pumpScreen(tester);

      await tester.tap(find.descendant(of: find.byType(SpinWheel), matching: find.byType(GestureDetector)));
      await finishSpin(tester);

      expect(find.textContaining('Congrats! You won'), findsOneWidget);
    });

    testWidgets('does not announce anything before the wheel stops', (tester) async {
      await pumpScreen(tester);

      await tester.tap(find.text('Spin the wheel now'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 2));

      expect(find.byType(SnackBar), findsNothing);

      await finishSpin(tester);
    });

    testWidgets('shows the prize name on one line in the snackbar', (tester) async {
      await pumpScreen(tester);

      await tester.tap(find.text('Spin the wheel now'));
      await finishSpin(tester);

      final message = tester.widget<Text>(find.descendant(of: find.byType(SnackBar), matching: find.byType(Text)));
      expect(message.data, isNot(contains('\n')));
    });
  });

  group('SpinWheelScreen use later', () {
    testWidgets('closes the screen', (tester) async {
      await tester.pumpAndPush((_) => const SpinWheelScreen());

      await tester.tap(find.text('Use later'));
      await tester.pumpAndSettle();

      expect(find.byType(SpinWheelScreen), findsNothing);
      expect(find.text(hostButtonText), findsOneWidget);
    });

    testWidgets('is ignored while the wheel is spinning', (tester) async {
      await tester.pumpAndPush((_) => const SpinWheelScreen());

      await tester.tap(find.text('Spin the wheel now'));
      await tester.pump(const Duration(seconds: 1));
      await tester.tap(find.text('Use later'));
      await tester.pump();

      expect(find.byType(SpinWheelScreen), findsOneWidget);

      await finishSpin(tester);
    });
  });

  group('SpinWheelScreen localization', () {
    testWidgets('shows the Arabic title', (tester) async {
      await pumpScreen(tester, locale: ar);

      expect(find.text('هديتك مستنياك!'), findsOneWidget);
    });
  });
}

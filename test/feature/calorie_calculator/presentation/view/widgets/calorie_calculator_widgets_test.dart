import 'package:flutter_test/flutter_test.dart';
import 'package:test_ui/core/utils/app_icons.dart';
import 'package:test_ui/feature/calorie_calculator/presentation/view/widgets/calculate_bottom_bar.dart';
import 'package:test_ui/feature/calorie_calculator/presentation/view/widgets/counter_field.dart';
import 'package:test_ui/feature/calorie_calculator/presentation/view/widgets/gender_option.dart';

import '../../../../../helpers/pump_app.dart';

void main() {
  group('CounterField', () {
    testWidgets('shows the value and calls the matching callback', (tester) async {
      var increases = 0;
      var decreases = 0;
      await tester.pumpApp(CounterField(value: 42, onIncrease: () => increases++, onDecrease: () => decreases++));

      expect(find.text('42'), findsOneWidget);

      await tester.tap(find.byIcon(AppIcons.plus));
      await tester.tap(find.byIcon(AppIcons.plus));
      await tester.tap(find.byIcon(AppIcons.minus));
      await tester.pump();

      expect(increases, 2);
      expect(decreases, 1);
    });
  });

  group('GenderOption', () {
    testWidgets('shows a check mark only when selected', (tester) async {
      await tester.pumpApp(GenderOption(label: 'Female', icon: AppIcons.female, isSelected: true, onTap: () {}));

      expect(find.text('Female'), findsOneWidget);
      expect(find.byIcon(AppIcons.check), findsOneWidget);
    });

    testWidgets('hides the check mark when not selected', (tester) async {
      await tester.pumpApp(GenderOption(label: 'Female', icon: AppIcons.female, isSelected: false, onTap: () {}));

      expect(find.byIcon(AppIcons.check), findsNothing);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      var taps = 0;
      await tester.pumpApp(GenderOption(label: 'Male', icon: AppIcons.male, isSelected: false, onTap: () => taps++));

      await tester.tap(find.text('Male'));
      await tester.pump();

      expect(taps, 1);
    });
  });

  group('CalculateBottomBar', () {
    testWidgets('shows the hint and calls onPressed', (tester) async {
      var taps = 0;
      await tester.pumpApp(CalculateBottomBar(buttonText: 'Calculate', hint: 'We will suggest a plan', onPressed: () => taps++));

      expect(find.text('We will suggest a plan'), findsOneWidget);

      await tester.tap(find.text('Calculate'));
      await tester.pump();

      expect(taps, 1);
    });
  });
}

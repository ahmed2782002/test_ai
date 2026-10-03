import 'package:flutter_test/flutter_test.dart';
import 'package:test_ui/core/utils/app_icons.dart';
import 'package:test_ui/feature/calorie_calculator/presentation/view/widgets/calculate_bottom_bar.dart';
import 'package:test_ui/feature/calorie_calculator/presentation/view/widgets/counter_action_button.dart';
import 'package:test_ui/feature/calorie_calculator/presentation/view/widgets/counter_field_row.dart';
import 'package:test_ui/feature/calorie_calculator/presentation/view/widgets/gender_option.dart';
import 'package:test_ui/feature/calorie_calculator/presentation/view/widgets/gender_selector.dart';
import 'package:test_ui/feature/calorie_calculator/presentation/view_model/calorie_calculator_state.dart';

import '../../../../../helpers/pump_app.dart';

Finder _genderCheckOn(String label) =>
    find.descendant(of: find.widgetWithText(GenderOption, label), matching: find.byIcon(AppIcons.check));

void main() {
  group('CounterFieldRow', () {
    testWidgets('shows the label, unit and value and calls the matching callback', (tester) async {
      var increases = 0;
      var decreases = 0;
      await tester.pumpApp(
        CounterFieldRow(label: 'Weight', unit: 'kg', value: 42, onIncrease: () => increases++, onDecrease: () => decreases++),
      );

      expect(find.byType(CounterActionButton), findsNWidgets(2));
      expect(find.text('42'), findsOneWidget);
      expect(find.text('Weightkg', findRichText: true), findsOneWidget);

      await tester.tap(find.byIcon(AppIcons.plus));
      await tester.tap(find.byIcon(AppIcons.plus));
      await tester.tap(find.byIcon(AppIcons.minus));
      await tester.pump();

      expect(increases, 2);
      expect(decreases, 1);
    });
  });

  group('GenderSelector', () {
    testWidgets('shows a check mark only on the selected option', (tester) async {
      await tester.pumpApp(GenderSelector(selected: Gender.female, onSelect: (_) {}));

      expect(find.text('Female'), findsOneWidget);
      expect(find.text('Male'), findsOneWidget);
      expect(find.byType(GenderOption), findsNWidgets(2));
      expect(find.byIcon(AppIcons.check), findsOneWidget);
      expect(_genderCheckOn('Female'), findsOneWidget);
      expect(_genderCheckOn('Male'), findsNothing);
    });

    testWidgets('moves the check mark when the other gender is selected', (tester) async {
      await tester.pumpApp(GenderSelector(selected: Gender.male, onSelect: (_) {}));

      expect(_genderCheckOn('Male'), findsOneWidget);
      expect(_genderCheckOn('Female'), findsNothing);
    });

    testWidgets('calls onSelect with the tapped gender', (tester) async {
      final selections = <Gender>[];
      await tester.pumpApp(GenderSelector(selected: Gender.female, onSelect: selections.add));

      await tester.tap(find.text('Male'));
      await tester.pump();

      expect(selections, [Gender.male]);
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

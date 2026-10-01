import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_ui/core/utils/app_icons.dart';
import 'package:test_ui/core/widgets/app_header/app_header.dart';
import 'package:test_ui/core/widgets/app_svg_icon/app_svg_icon.dart';
import 'package:test_ui/feature/calorie_calculator/presentation/view/screen/calorie_calculator_screen.dart';
import 'package:test_ui/feature/calorie_calculator/presentation/view/widgets/activity_level_card.dart';
import 'package:test_ui/feature/calorie_calculator/presentation/view/widgets/gender_option.dart';
import 'package:test_ui/feature/calorie_calculator/presentation/view/widgets/goal_card.dart';
import 'package:test_ui/feature/calorie_calculator/presentation/view/widgets/labeled_field_row.dart';
import 'package:test_ui/feature/calorie_calculator/presentation/view_model/calorie_calculator_cubit.dart';
import 'package:test_ui/feature/calorie_results/presentation/view/screen/calorie_results_screen.dart';

import '../../../../../helpers/pump_app.dart';

Finder _counterOf(String label) => find.byWidgetPredicate((widget) => widget is LabeledFieldRow && widget.label == label);

Finder _plusOf(String label) => find.descendant(of: _counterOf(label), matching: find.byIcon(AppIcons.plus));

Finder _minusOf(String label) => find.descendant(of: _counterOf(label), matching: find.byIcon(AppIcons.minus));

Finder _valueOf(String label, int value) => find.descendant(of: _counterOf(label), matching: find.text('$value'));

final Finder _checkCircle = find.byWidgetPredicate((widget) => widget is AppSvgIcon && widget.asset == AppIcons.checkCircle);

Finder _checkMarkOn<T extends Widget>(String title) =>
    find.descendant(of: find.widgetWithText(T, title), matching: _checkCircle);

void main() {
  late CalorieCalculatorCubit cubit;

  setUp(() => cubit = CalorieCalculatorCubit());
  tearDown(() => cubit.close());

  Future<void> pumpScreen(WidgetTester tester, {Locale locale = en}) {
    return tester.pumpApp(
      const CalorieCalculatorScreen(),
      wrapInScaffold: false,
      locale: locale,
      wrapper: (app) => BlocProvider.value(value: cubit, child: app),
    );
  }

  group('CalorieCalculatorScreen initial state', () {
    testWidgets('shows title, sections and the calculate button', (tester) async {
      await pumpScreen(tester);

      expect(find.text('Calorie Calculator'), findsOneWidget);
      expect(find.text('Your basic info'), findsOneWidget);
      expect(find.text('Activity level'), findsOneWidget);
      expect(find.text('What is your goal?'), findsOneWidget);
      expect(find.text('Calculate my calories'), findsOneWidget);
    });

    testWidgets('shows default weight, height and age', (tester) async {
      await pumpScreen(tester);

      expect(_valueOf('Weight', 80), findsOneWidget);
      expect(_valueOf('Height', 175), findsOneWidget);
      expect(_valueOf('Age', 28), findsOneWidget);
    });

    testWidgets('pre-selects male, moderate activity and maintain weight', (tester) async {
      await pumpScreen(tester);

      expect(find.descendant(of: find.widgetWithText(GenderOption, 'Male'), matching: find.byIcon(AppIcons.check)), findsOneWidget);
      expect(_checkMarkOn<ActivityLevelCard>('Moderate'), findsOneWidget);
      expect(_checkMarkOn<GoalCard>('Maintain weight'), findsOneWidget);
    });
  });

  group('CalorieCalculatorScreen counters', () {
    testWidgets('increases weight when tapping plus', (tester) async {
      await pumpScreen(tester);

      await tester.tap(_plusOf('Weight'));
      await tester.pump();

      expect(_valueOf('Weight', 81), findsOneWidget);
    });

    testWidgets('decreases height when tapping minus', (tester) async {
      await pumpScreen(tester);

      await tester.tap(_minusOf('Height'));
      await tester.pump();

      expect(_valueOf('Height', 174), findsOneWidget);
    });

    testWidgets('does not go below the minimum age', (tester) async {
      await pumpScreen(tester);

      for (var i = 0; i < 25; i++) {
        await tester.tap(_minusOf('Age'));
        await tester.pump();
      }

      expect(_valueOf('Age', CalorieCalculatorCubit.minAge), findsOneWidget);
    });
  });

  group('CalorieCalculatorScreen selection', () {
    testWidgets('moves the gender check mark to female when tapped', (tester) async {
      await pumpScreen(tester);

      await tester.tap(find.text('Female'));
      await tester.pumpAndSettle();

      expect(find.descendant(of: find.widgetWithText(GenderOption, 'Female'), matching: find.byIcon(AppIcons.check)), findsOneWidget);
      expect(find.descendant(of: find.widgetWithText(GenderOption, 'Male'), matching: find.byIcon(AppIcons.check)), findsNothing);
    });

    testWidgets('selects a different activity level', (tester) async {
      await pumpScreen(tester);

      await tester.tap(find.text('Sedentary'));
      await tester.pumpAndSettle();

      expect(_checkMarkOn<ActivityLevelCard>('Sedentary'), findsOneWidget);
      expect(_checkMarkOn<ActivityLevelCard>('Moderate'), findsNothing);
    });

    testWidgets('selects a different goal', (tester) async {
      await pumpScreen(tester);

      await tester.ensureVisible(find.text('Gain weight'));
      await tester.tap(find.text('Gain weight'));
      await tester.pumpAndSettle();

      expect(_checkMarkOn<GoalCard>('Gain weight'), findsOneWidget);
      expect(_checkMarkOn<GoalCard>('Maintain weight'), findsNothing);
    });
  });

  group('CalorieCalculatorScreen navigation', () {
    testWidgets('opens calorie results when tapping calculate', (tester) async {
      await pumpScreen(tester);

      await tester.tap(find.text('Calculate my calories'));
      await tester.pumpAndSettle();

      expect(find.byType(CalorieResultsScreen), findsOneWidget);
      expect(find.text('Calorie Results'), findsOneWidget);
    });

    testWidgets('can calculate again after coming back from the results', (tester) async {
      await pumpScreen(tester);

      await tester.tap(find.text('Calculate my calories'));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(AppHeader), matching: find.byType(IconButton)));
      await tester.pumpAndSettle();
      expect(find.byType(CalorieResultsScreen), findsNothing);

      await tester.tap(find.text('Calculate my calories'));
      await tester.pumpAndSettle();

      expect(find.byType(CalorieResultsScreen), findsOneWidget);
    });

    testWidgets('keeps the entered values after returning with the system back button', (tester) async {
      await pumpScreen(tester);

      await tester.tap(_plusOf('Weight'));
      await tester.pump();
      await tester.tap(find.text('Calculate my calories'));
      await tester.pumpAndSettle();
      await tester.binding.handlePopRoute(); // Android back button / gesture
      await tester.pumpAndSettle();

      expect(_valueOf('Weight', 81), findsOneWidget);
    });

    testWidgets('back button closes the screen', (tester) async {
      await tester.pumpAndPush(
        (_) => const CalorieCalculatorScreen(),
        wrapper: (app) => BlocProvider.value(value: cubit, child: app),
      );

      await tester.tap(find.descendant(of: find.byType(AppHeader), matching: find.byType(IconButton)));
      await tester.pumpAndSettle();

      expect(find.byType(CalorieCalculatorScreen), findsNothing);
      expect(find.text(hostButtonText), findsOneWidget);
    });
  });

  group('CalorieCalculatorScreen localization', () {
    testWidgets('shows the Arabic title', (tester) async {
      await pumpScreen(tester, locale: ar);

      expect(find.text('برنامج حساب السعرات'), findsOneWidget);
    });
  });
}

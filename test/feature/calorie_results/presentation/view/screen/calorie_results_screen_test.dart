import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_ui/core/widgets/app_header/app_header.dart';
import 'package:test_ui/feature/calorie_results/presentation/view/screen/calorie_results_screen.dart';
import 'package:test_ui/feature/calorie_results/presentation/view/widgets/calorie_results_shimmer.dart';
import 'package:test_ui/feature/calorie_results/presentation/view_model/calorie_results_cubit.dart';
import 'package:test_ui/feature/calorie_results/presentation/view_model/calorie_results_state.dart';
import 'package:test_ui/feature/layout/presentation/view/screen/layout_screen.dart';

import '../../../../../helpers/pump_app.dart';

/// Real cubit whose `load` emits a fixed status, so every screen state can be rendered.
class _FixedStatusResultsCubit extends CalorieResultsCubit {
  _FixedStatusResultsCubit(this._status) {
    emit(CalorieResultsState(status: _status));
  }

  final CalorieResultsStatus _status;
  int loadCalls = 0;

  @override
  void load() {
    loadCalls++;
    emit(CalorieResultsState(status: _status));
  }
}

void main() {
  late CalorieResultsCubit cubit;

  tearDown(() => cubit.close());

  Future<void> pumpScreen(WidgetTester tester, {Locale locale = en}) {
    return tester.pumpApp(
      const CalorieResultsScreen(),
      wrapInScaffold: false,
      locale: locale,
      wrapper: (app) => BlocProvider.value(value: cubit, child: app),
    );
  }

  group('CalorieResultsScreen states', () {
    testWidgets('shows shimmer while loading', (tester) async {
      cubit = _FixedStatusResultsCubit(CalorieResultsStatus.loading);
      await pumpScreen(tester);

      expect(find.byType(CalorieResultsShimmer), findsOneWidget);
      expect(find.text('Your daily need'), findsNothing);
      expect(find.text('Calorie Results'), findsOneWidget); // header stays visible
    });

    testWidgets('shows error message and retries on tap', (tester) async {
      final failing = _FixedStatusResultsCubit(CalorieResultsStatus.failure);
      cubit = failing;
      await pumpScreen(tester);

      expect(find.text('Something went wrong while loading your results'), findsOneWidget);

      await tester.tap(find.text('Retry'));
      await tester.pump();

      expect(failing.loadCalls, 1);
    });

    testWidgets('shows daily calories and macronutrients on success', (tester) async {
      cubit = CalorieResultsCubit()..load();
      await pumpScreen(tester);

      expect(find.text('Your daily need'), findsOneWidget);
      expect(find.text('2,450'), findsOneWidget);
      expect(find.text('kcal'), findsOneWidget);
      expect(find.text('Protein'), findsOneWidget);
      expect(find.text('150g'), findsOneWidget);
      expect(find.text('Carbs'), findsOneWidget);
      expect(find.text('280g'), findsOneWidget);
      expect(find.text('Fats'), findsOneWidget);
      expect(find.text('65g'), findsOneWidget);
    });

    testWidgets('shows the suggested package with price, badge and features', (tester) async {
      cubit = CalorieResultsCubit()..load();
      await pumpScreen(tester);

      await tester.ensureVisible(find.text('Subscribe now'));
      await tester.pumpAndSettle();

      expect(find.text('Plans that suit you'), findsOneWidget);
      expect(find.text('Healthy Balance Plan'), findsOneWidget);
      expect(find.text('Fits your goal'), findsOneWidget);
      expect(find.text('899'), findsOneWidget);
      expect(find.text('SAR'), findsOneWidget);
      expect(find.text('/ month'), findsOneWidget);
      expect(find.text('3 meals a day'), findsOneWidget);
      expect(find.text('Free delivery'), findsOneWidget);
      expect(find.text('Free consultation with a nutritionist'), findsOneWidget);
    });
  });

  group('CalorieResultsScreen navigation', () {
    testWidgets('subscribing replaces the whole stack with the main layout', (tester) async {
      cubit = CalorieResultsCubit()..load();
      await tester.pumpAndPush(
        (_) => const CalorieResultsScreen(),
        wrapper: (app) => BlocProvider.value(value: cubit, child: app),
      );

      await tester.ensureVisible(find.text('Subscribe now'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Subscribe now'));
      // The home tab shows an infinite shimmer while it loads, so advance time
      // explicitly instead of pumpAndSettle.
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(LayoutScreen), findsOneWidget);
      expect(find.byType(CalorieResultsScreen), findsNothing);
      expect(find.text(hostButtonText), findsNothing); // previous routes were removed
    });

    testWidgets('back button closes the screen', (tester) async {
      cubit = CalorieResultsCubit()..load();
      await tester.pumpAndPush(
        (_) => const CalorieResultsScreen(),
        wrapper: (app) => BlocProvider.value(value: cubit, child: app),
      );

      await tester.tap(find.descendant(of: find.byType(AppHeader), matching: find.byType(IconButton)));
      await tester.pumpAndSettle();

      expect(find.byType(CalorieResultsScreen), findsNothing);
      expect(find.text(hostButtonText), findsOneWidget);
    });
  });

  group('CalorieResultsScreen localization', () {
    testWidgets('shows the Arabic title', (tester) async {
      cubit = CalorieResultsCubit()..load();
      await pumpScreen(tester, locale: ar);

      expect(find.text('نتائج السعرات'), findsOneWidget);
    });
  });
}

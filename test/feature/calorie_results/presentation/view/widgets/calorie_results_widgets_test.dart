import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_ui/core/utils/app_icons.dart';
import 'package:test_ui/core/utils/app_images.dart';
import 'package:test_ui/feature/calorie_results/mock_model/calorie_results_model.dart';
import 'package:test_ui/feature/calorie_results/mock_model/package_model.dart';
import 'package:test_ui/feature/calorie_results/presentation/view/widgets/macro_nutrient_card.dart';
import 'package:test_ui/feature/calorie_results/presentation/view/widgets/macros_section.dart';
import 'package:test_ui/feature/calorie_results/presentation/view/widgets/package_card.dart';
import 'package:test_ui/feature/calorie_results/presentation/view/widgets/package_feature_row.dart';
import 'package:test_ui/feature/calorie_results/presentation/view/widgets/packages_section.dart';

import '../../../../../helpers/pump_app.dart';

// Names, descriptions and feature titles are translation keys in the real model;
// plain strings fall back to themselves, so they render as-is.
PackageModel _package({bool fitsGoal = false}) {
  return PackageModel(
    name: 'Healthy Balance Plan',
    description: 'Maintain your weight',
    image: AppImages.testHealthyBalancePackage,
    monthlyPrice: 899,
    fitsGoal: fitsGoal,
    features: const [(icon: AppIcons.delivery, iconSize: Size(16.5, 12), title: 'Free delivery')],
  );
}

Widget _packagesSection({bool fitsGoal = false, VoidCallback? onSubscribe, VoidCallback? onViewAll}) {
  return SingleChildScrollView(
    child: PackagesSection(
      packages: [_package(fitsGoal: fitsGoal)],
      onViewAll: onViewAll ?? () {},
      onSubscribe: onSubscribe ?? () {},
    ),
  );
}

void main() {
  group('PackagesSection package card', () {
    testWidgets('shows name, description, price and features', (tester) async {
      await tester.pumpApp(_packagesSection());

      expect(find.byType(PackageCard), findsOneWidget);
      expect(find.byType(PackageFeatureRow), findsOneWidget);
      expect(find.text('Healthy Balance Plan'), findsOneWidget);
      expect(find.text('Maintain your weight'), findsOneWidget);
      expect(find.text('899'), findsOneWidget);
      expect(find.text('SAR'), findsOneWidget);
      expect(find.text('/ month'), findsOneWidget);
      expect(find.text('Free delivery'), findsOneWidget);
    });

    testWidgets('shows the badge only when the package fits the goal', (tester) async {
      await tester.pumpApp(_packagesSection(fitsGoal: true));
      expect(find.text('Fits your goal'), findsOneWidget);

      await tester.pumpApp(_packagesSection());
      expect(find.text('Fits your goal'), findsNothing);
    });

    testWidgets('calls onSubscribe when tapping the subscribe button', (tester) async {
      var taps = 0;
      await tester.pumpApp(_packagesSection(onSubscribe: () => taps++));

      await tester.ensureVisible(find.text('Subscribe now'));
      await tester.tap(find.text('Subscribe now'));
      await tester.pump();

      expect(taps, 1);
    });
  });

  group('MacrosSection', () {
    testWidgets('shows the macro name and value', (tester) async {
      await tester.pumpApp(
        const MacrosSection(macros: [(type: MacroType.protein, grams: 150, progress: 0.4)]),
      );

      expect(find.text('Protein'), findsOneWidget);
      expect(find.text('150g'), findsOneWidget);
    });

    testWidgets('does not break with progress outside 0..1', (tester) async {
      await tester.pumpApp(
        const MacrosSection(
          macros: [
            (type: MacroType.fats, grams: 999, progress: 1.7),
            (type: MacroType.carbs, grams: 1, progress: -0.5),
          ],
        ),
      );

      expect(tester.takeException(), isNull);
      expect(find.text('999g'), findsOneWidget);
      expect(find.byType(MacroNutrientCard), findsNWidgets(2));
    });
  });

  group('PackagesSection header', () {
    testWidgets('shows the title and calls onViewAll', (tester) async {
      var taps = 0;
      await tester.pumpApp(_packagesSection(onViewAll: () => taps++));

      expect(find.text('Plans that suit you'), findsOneWidget);

      await tester.tap(find.text('View all'));
      await tester.pump();

      expect(taps, 1);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_ui/core/utils/app_icons.dart';
import 'package:test_ui/core/utils/app_images.dart';
import 'package:test_ui/feature/calorie_results/presentation/view/widgets/macro_nutrient_card.dart';
import 'package:test_ui/feature/calorie_results/presentation/view/widgets/package_card.dart';
import 'package:test_ui/feature/calorie_results/presentation/view/widgets/packages_section_header.dart';

import '../../../../../helpers/pump_app.dart';

Widget _packageCard({String? badgeText, VoidCallback? onAction}) {
  return SingleChildScrollView(
    child: PackageCard(
      image: AppImages.testHealthyBalancePackage,
      name: 'Healthy Balance Plan',
      description: 'Maintain your weight',
      price: '899',
      currency: 'SAR',
      period: '/ month',
      badgeText: badgeText,
      features: const [Text('Free delivery')],
      actionText: 'Subscribe now',
      onAction: onAction ?? () {},
    ),
  );
}

void main() {
  group('PackageCard', () {
    testWidgets('shows name, description, price and features', (tester) async {
      await tester.pumpApp(_packageCard());

      expect(find.text('Healthy Balance Plan'), findsOneWidget);
      expect(find.text('Maintain your weight'), findsOneWidget);
      expect(find.text('899'), findsOneWidget);
      expect(find.text('SAR'), findsOneWidget);
      expect(find.text('/ month'), findsOneWidget);
      expect(find.text('Free delivery'), findsOneWidget);
    });

    testWidgets('shows the badge only when badgeText is given', (tester) async {
      await tester.pumpApp(_packageCard(badgeText: 'Fits your goal'));
      expect(find.text('Fits your goal'), findsOneWidget);

      await tester.pumpApp(_packageCard());
      expect(find.text('Fits your goal'), findsNothing);
    });

    testWidgets('calls onAction when tapping the subscribe button', (tester) async {
      var taps = 0;
      await tester.pumpApp(_packageCard(onAction: () => taps++));

      await tester.ensureVisible(find.text('Subscribe now'));
      await tester.tap(find.text('Subscribe now'));
      await tester.pump();

      expect(taps, 1);
    });
  });

  group('MacroNutrientCard', () {
    testWidgets('shows the macro name and value', (tester) async {
      await tester.pumpApp(
        const MacroNutrientCard(
          icon: AppIcons.proteinPlate,
          iconSize: Size(22, 19),
          color: Colors.green,
          lightColor: Colors.lightGreen,
          name: 'Protein',
          value: '150g',
          progress: 0.4,
        ),
      );

      expect(find.text('Protein'), findsOneWidget);
      expect(find.text('150g'), findsOneWidget);
    });

    testWidgets('does not break with progress outside 0..1', (tester) async {
      await tester.pumpApp(
        const MacroNutrientCard(
          icon: AppIcons.fats,
          iconSize: Size(14, 18),
          color: Colors.orange,
          lightColor: Colors.orangeAccent,
          name: 'Fats',
          value: '999g',
          progress: 1.7,
        ),
      );

      expect(tester.takeException(), isNull);
    });
  });

  group('PackagesSectionHeader', () {
    testWidgets('shows the title and calls onAction', (tester) async {
      var taps = 0;
      await tester.pumpApp(PackagesSectionHeader(title: 'Plans that suit you', actionText: 'View all', onAction: () => taps++));

      expect(find.text('Plans that suit you'), findsOneWidget);

      await tester.tap(find.text('View all'));
      await tester.pump();

      expect(taps, 1);
    });
  });
}

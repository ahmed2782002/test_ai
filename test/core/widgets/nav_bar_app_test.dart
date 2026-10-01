import 'package:flutter_test/flutter_test.dart';
import 'package:test_ui/core/utils/app_icons.dart';
import 'package:test_ui/core/widgets/nav_bar_app/nav_bar_app.dart';
import 'package:test_ui/core/widgets/nav_bar_app/nav_bar_center_button_app.dart';
import 'package:test_ui/core/widgets/nav_bar_app/nav_bar_item_data.dart';

import '../../helpers/pump_app.dart';

const _items = [
  NavBarItemData(icon: AppIcons.navHome, iconHeight: 18, label: 'Home'),
  NavBarItemData(icon: AppIcons.navOrders, iconHeight: 24, label: 'Orders'),
  NavBarItemData(icon: AppIcons.navCalories, iconHeight: 20, label: 'Calories'),
  NavBarItemData(icon: AppIcons.navMeals, iconHeight: 20, label: 'Meals'),
  NavBarItemData(icon: AppIcons.navAccount, iconHeight: 24, label: 'Account'),
];

void main() {
  late List<int> tappedIndexes;

  setUp(() => tappedIndexes = []);

  Future<void> pumpNavBar(WidgetTester tester) {
    return tester.pumpApp(NavBarApp(items: _items, currentIndex: 0, onTap: tappedIndexes.add));
  }

  group('NavBarApp', () {
    testWidgets('shows every item label', (tester) async {
      await pumpNavBar(tester);

      for (final item in _items) {
        expect(find.text(item.label), findsOneWidget, reason: item.label);
      }
    });

    testWidgets('reports the index of the tapped item', (tester) async {
      await pumpNavBar(tester);

      await tester.tap(find.text('Orders'));
      await tester.tap(find.text('Account'));
      await tester.pump();

      expect(tappedIndexes, [1, 4]);
    });

    testWidgets('reports the center index from both the label and the raised button', (tester) async {
      await pumpNavBar(tester);

      await tester.tap(find.text('Calories'));
      await tester.tap(find.byType(NavBarCenterButtonApp));
      await tester.pump();

      expect(tappedIndexes, [2, 2]);
    });
  });
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_ui/feature/cinema_details/presentation/view/screen/cinema_details_screen.dart';
import 'package:test_ui/main.dart';

import 'helpers/pump_app.dart';
import 'helpers/test_asset_loader.dart';

void main() {
  testWidgets('MyApp starts on the cinema details screen', (tester) async {
    tester.view.physicalSize = designSize;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    // Same setup as main(), with in-memory translations.
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [ar, en],
        path: 'assets/translations',
        assetLoader: const TestAssetLoader(),
        fallbackLocale: en,
        startLocale: en,
        saveLocale: false,
        child: const MyApp(),
      ),
    );
    for (var i = 0; i < 10 && find.byType(MaterialApp).evaluate().isEmpty; i++) {
      await tester.pump();
    }
    await tester.pump();

    expect(find.byType(CinemaDetailsScreen), findsOneWidget);
    expect(find.text('Movies'), findsOneWidget);
  });
}

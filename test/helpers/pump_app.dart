import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_ui/core/theme/app_colors.dart';

import 'test_asset_loader.dart';

const Locale en = Locale('en');
const Locale ar = Locale('ar');

/// The Figma frame size the app is designed against (see `main.dart`).
const Size designSize = Size(390, 844);

extension PumpApp on WidgetTester {
  /// Pumps [widget] with the same ancestors the app uses:
  /// [EasyLocalization] -> [ScreenUtilInit] -> [MaterialApp].
  ///
  /// - Components: keep [wrapInScaffold] `true` (default) so they get a [Material] ancestor.
  /// - Screens that own a [Scaffold]: pass `wrapInScaffold: false`.
  /// - Cubits: pass [wrapper], e.g. `(app) => BlocProvider.value(value: cubit, child: app)`.
  ///   It wraps the whole [MaterialApp], so pushed routes can read it too.
  ///
  /// The view is pinned to [size] (logical pixels, DPR 1) and reset after the test.
  Future<void> pumpApp(
    Widget widget, {
    bool wrapInScaffold = true,
    Locale locale = en,
    Size size = designSize,
    Map<String, WidgetBuilder> routes = const {},
    List<NavigatorObserver> navigatorObservers = const [],
    Widget Function(Widget app)? wrapper,
  }) async {
    view.physicalSize = size;
    view.devicePixelRatio = 1;
    addTearDown(view.reset);

    await pumpWidget(
      EasyLocalization(
        supportedLocales: const [ar, en],
        path: 'assets/translations',
        assetLoader: const TestAssetLoader(),
        fallbackLocale: en,
        startLocale: locale,
        saveLocale: false,
        child: ScreenUtilInit(
          designSize: designSize,
          minTextAdapt: true,
          builder: (context, _) {
            final app = MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: ThemeData(
                scaffoldBackgroundColor: AppColors.background,
                colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
              ),
              routes: routes,
              navigatorObservers: navigatorObservers,
              home: wrapInScaffold ? Scaffold(body: widget) : widget,
            );
            return wrapper == null ? app : wrapper(app);
          },
        ),
      ),
    );

    // EasyLocalization renders nothing until its translations future resolves.
    for (var i = 0; i < 10 && find.byType(MaterialApp).evaluate().isEmpty; i++) {
      await pump();
    }
    await pump();
  }

  /// Pumps a host page, then pushes the route built by [builder] on top of it.
  ///
  /// Use it to verify that a screen closes itself (back button, "use later", ...):
  /// after the screen pops, [hostButtonText] is visible again.
  Future<void> pumpAndPush(
    WidgetBuilder builder, {
    Locale locale = en,
    Widget Function(Widget app)? wrapper,
  }) async {
    await pumpApp(
      Builder(
        builder: (context) => TextButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute<void>(builder: builder)),
          child: const Text(hostButtonText),
        ),
      ),
      locale: locale,
      wrapper: wrapper,
    );
    await tap(find.text(hostButtonText));
    await pumpAndSettle();
  }
}

const String hostButtonText = 'Open screen';

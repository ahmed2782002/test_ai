import 'dart:io';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_ui/core/theme/app_colors.dart';
import 'package:test_ui/feature/home/presentation/view/widgets/home_header.dart';
import 'package:test_ui/feature/layout/presentation/view/screen/layout_screen.dart';

const String captureDir = String.fromEnvironment('HOME_CAPTURE_DIR');
const ValueKey<String> boundaryKey = ValueKey('home-boundary');

Future<void> loadFonts() async {
  final regular = File('C:/Windows/Fonts/segoeui.ttf');
  if (!regular.existsSync()) return;
  final text = FontLoader('Roboto')
    ..addFont(Future.value(ByteData.sublistView(regular.readAsBytesSync())))
    ..addFont(Future.value(ByteData.sublistView(File('C:/Windows/Fonts/segoeuib.ttf').readAsBytesSync())));
  await text.load();
  final icons = FontLoader('MaterialIcons')
    ..addFont(
      Future.value(
        ByteData.sublistView(File('C:/flutter/bin/cache/artifacts/material_fonts/materialicons-regular.otf').readAsBytesSync()),
      ),
    );
  await icons.load();
}

Widget buildApp({required Locale locale, required Size designSize}) {
  return EasyLocalization(
    supportedLocales: const [Locale('ar'), Locale('en')],
    path: 'assets/translations',
    fallbackLocale: const Locale('ar'),
    startLocale: locale,
    saveLocale: false,
    child: Builder(
      builder: (context) => ScreenUtilInit(
        designSize: designSize,
        minTextAdapt: true,
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.background,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          ),
          builder: (context, child) => KeyedSubtree(key: ValueKey(context.locale), child: child!),
          home: const RepaintBoundary(key: boundaryKey, child: LayoutScreen()),
        ),
      ),
    ),
  );
}

Future<void> pumpHome(WidgetTester tester, {required Locale locale, required Size size, Size designSize = const Size(390, 844)}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.runAsync(() => tester.pumpWidget(buildApp(locale: locale, designSize: designSize)));
  await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 300)));
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
  await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 300)));
  await tester.pump(const Duration(milliseconds: 100));
}

Future<void> capture(WidgetTester tester, String name) async {
  if (captureDir.isEmpty) return;
  final boundary = tester.renderObject<RenderRepaintBoundary>(find.byKey(boundaryKey));
  await tester.runAsync(() async {
    final image = await boundary.toImage();
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    File('$captureDir/$name.png').writeAsBytesSync(bytes!.buffer.asUint8List());
  });
}

Future<void> scrollToEnd(WidgetTester tester) async {
  final list = find.byType(Scrollable).first;
  for (var index = 0; index < 8; index++) {
    await tester.drag(list, const Offset(0, -300));
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  setUpAll(loadFonts);

  for (final locale in const [Locale('ar'), Locale('en')]) {
    testWidgets('home full capture ${locale.languageCode}', (tester) async {
      await pumpHome(tester, locale: locale, size: const Size(390, 1755), designSize: const Size(390, 1755));
      expect(find.byType(HomeHeader), findsOneWidget);
      await capture(tester, 'home_full_${locale.languageCode}');
    });

    for (final size in const [Size(320, 568), Size(430, 932)]) {
      testWidgets('home has no overflow ${locale.languageCode} ${size.width.toInt()}x${size.height.toInt()}', (tester) async {
        await pumpHome(tester, locale: locale, size: size);
        expect(find.byType(HomeHeader), findsOneWidget);
        await capture(tester, 'home_${locale.languageCode}_${size.width.toInt()}');
        await scrollToEnd(tester);
        expect(tester.takeException(), isNull);
      });
    }
  }

  testWidgets('home switches language while open', (tester) async {
    await pumpHome(tester, locale: const Locale('ar'), size: const Size(390, 844));
    expect(find.text('مرحبًا أحمد'), findsOneWidget);
    final context = tester.element(find.byType(HomeHeader));
    await tester.runAsync(() => EasyLocalization.of(context)!.setLocale(const Locale('en')));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 300)));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Hello, Ahmed'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('899 SAR'), findsWidgets);
  });
}

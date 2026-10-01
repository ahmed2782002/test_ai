import 'dart:io';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_ui/core/theme/app_colors.dart';
import 'package:test_ui/feature/cinema_details/presentation/view/screen/cinema_details_screen.dart';
import 'package:test_ui/feature/cinema_details/presentation/view/widgets/comment_card.dart';
import 'package:test_ui/feature/cinema_details/presentation/view_model/cinema_details_cubit.dart';

const String captureDir = String.fromEnvironment('CINEMA_CAPTURE_DIR');
const ValueKey<String> boundaryKey = ValueKey('cinema-boundary');

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
          home: RepaintBoundary(
            key: boundaryKey,
            child: BlocProvider(
              create: (_) => CinemaDetailsCubit()..load(),
              child: const CinemaDetailsScreen(),
            ),
          ),
        ),
      ),
    ),
  );
}

Future<void> settle(WidgetTester tester) async {
  await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 300)));
  await tester.pump();
  await tester.pump(const Duration(seconds: 1));
  await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 300)));
  await tester.pump(const Duration(milliseconds: 100));
}

Future<void> pumpCinema(WidgetTester tester, {required Locale locale, required Size size, Size designSize = const Size(390, 844)}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.runAsync(() => tester.pumpWidget(buildApp(locale: locale, designSize: designSize)));
  await settle(tester);
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
    testWidgets('cinema details full capture ${locale.languageCode}', (tester) async {
      await pumpCinema(tester, locale: locale, size: const Size(390, 1194), designSize: const Size(390, 1194));
      expect(find.byType(CommentCard), findsNWidgets(3));
      await capture(tester, 'cinema_full_${locale.languageCode}');
      expect(tester.takeException(), isNull);
    });

    for (final size in const [Size(320, 568), Size(430, 932)]) {
      testWidgets('cinema details has no overflow ${locale.languageCode} ${size.width.toInt()}x${size.height.toInt()}', (tester) async {
        await pumpCinema(tester, locale: locale, size: size);
        await capture(tester, 'cinema_${locale.languageCode}_${size.width.toInt()}');
        await scrollToEnd(tester);
        expect(tester.takeException(), isNull);
      });
    }
  }

  testWidgets('cinema details switches language while open', (tester) async {
    await pumpCinema(tester, locale: const Locale('ar'), size: const Size(390, 844));
    expect(find.text('الأفلام'), findsOneWidget);
    final context = tester.element(find.byType(CinemaDetailsScreen));
    await tester.runAsync(() => EasyLocalization.of(context)!.setLocale(const Locale('en')));
    await settle(tester);
    expect(find.text('Movies'), findsOneWidget);
    expect(find.text('2 hour 5 minutes'), findsNWidgets(2));
  });

  testWidgets('cinema details adds a sent comment', (tester) async {
    await pumpCinema(tester, locale: const Locale('en'), size: const Size(390, 844));
    await tester.enterText(find.byType(TextField), 'Nice place');
    await tester.testTextInput.receiveAction(TextInputAction.send);
    await tester.pump();
    expect(find.byType(CommentCard, skipOffstage: false), findsNWidgets(4));
    expect(find.textContaining('Nice place', skipOffstage: false), findsOneWidget);
  });
}

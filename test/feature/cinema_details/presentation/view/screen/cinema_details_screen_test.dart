import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_ui/core/theme/app_colors.dart';
import 'package:test_ui/core/utils/app_icons.dart';
import 'package:test_ui/feature/cinema_details/presentation/view/screen/cinema_details_screen.dart';
import 'package:test_ui/feature/cinema_details/presentation/view/widgets/cinema_details_shimmer.dart';
import 'package:test_ui/feature/cinema_details/presentation/view/widgets/cinema_header.dart';
import 'package:test_ui/feature/cinema_details/presentation/view/widgets/comment_card.dart';
import 'package:test_ui/feature/cinema_details/presentation/view/widgets/movie_card.dart';
import 'package:test_ui/feature/cinema_details/presentation/view_model/cinema_details_cubit.dart';
import 'package:test_ui/feature/cinema_details/presentation/view_model/cinema_details_state.dart';

import '../../../../../helpers/pump_app.dart';

/// Real cubit whose `load` emits a fixed status, so every screen state can be rendered.
class _FixedStatusCinemaCubit extends CinemaDetailsCubit {
  _FixedStatusCinemaCubit(this._status) {
    emit(CinemaDetailsState(status: _status));
  }

  final CinemaDetailsStatus _status;
  int loadCalls = 0;

  @override
  Future<void> load() async {
    loadCalls++;
    emit(CinemaDetailsState(status: _status));
  }
}

Finder _commentCards() => find.byType(CommentCard, skipOffstage: false);

Finder _movieCards() => find.byType(MovieCard);

void main() {
  late CinemaDetailsCubit cubit;

  tearDown(() => cubit.close());

  Future<void> pumpScreen(WidgetTester tester, {Locale locale = en}) {
    return tester.pumpApp(
      const CinemaDetailsScreen(),
      wrapInScaffold: false,
      locale: locale,
      wrapper: (app) => BlocProvider.value(value: cubit, child: app),
    );
  }

  group('CinemaDetailsScreen states', () {
    testWidgets('shows shimmer while loading', (tester) async {
      cubit = _FixedStatusCinemaCubit(CinemaDetailsStatus.loading);
      await pumpScreen(tester);

      expect(find.byType(CinemaDetailsShimmer), findsOneWidget);
      expect(find.text('Movies'), findsNothing);
    });

    testWidgets('shows error message and retries on tap', (tester) async {
      final failing = _FixedStatusCinemaCubit(CinemaDetailsStatus.failure);
      cubit = failing;
      await pumpScreen(tester);

      expect(find.text('Something went wrong while loading the cinema details'), findsOneWidget);

      await tester.tap(find.text('Retry'));
      await tester.pump();

      expect(failing.loadCalls, 1);
    });

    testWidgets('shows cinema, movies and comments on success', (tester) async {
      cubit = CinemaDetailsCubit()..load();
      await pumpScreen(tester);

      expect(find.textContaining('IMAX cinema', findRichText: true), findsOneWidget);
      expect(find.text('Movies'), findsOneWidget);
      expect(_movieCards(), findsNWidgets(2));
      expect(find.textContaining('Shazam: Fury of the Gods'), findsOneWidget);
      expect(find.text('2 hour 5 minutes'), findsNWidgets(2));
      expect(_commentCards(), findsNWidgets(3));
    });

    testWidgets('fills 4 of 5 stars for a 4.8 rating', (tester) async {
      cubit = CinemaDetailsCubit()..load();
      await pumpScreen(tester);

      final filledStars = find.byWidgetPredicate(
        (widget) => widget is Icon && widget.icon == AppIcons.starSharp && widget.color == AppColors.cinemaStar,
      );
      final emptyStars = find.byWidgetPredicate(
        (widget) => widget is Icon && widget.icon == AppIcons.starSharp && widget.color == AppColors.cinemaStarInactive,
      );

      expect(filledStars, findsNWidgets(4));
      expect(emptyStars, findsOneWidget);
    });
  });

  group('CinemaDetailsScreen comments', () {
    testWidgets('adds a comment when tapping send', (tester) async {
      cubit = CinemaDetailsCubit()..load();
      await pumpScreen(tester);

      await tester.enterText(find.byType(TextField), 'Great sound');
      await tester.tap(find.byIcon(AppIcons.send));
      await tester.pump();

      expect(_commentCards(), findsNWidgets(4));
      expect(find.textContaining('Great sound', skipOffstage: false), findsOneWidget);
      expect(find.textContaining('@me', skipOffstage: false), findsOneWidget);
    });

    testWidgets('adds a comment when submitting from the keyboard and clears the field', (tester) async {
      cubit = CinemaDetailsCubit()..load();
      await pumpScreen(tester);

      await tester.enterText(find.byType(TextField), 'Nice place');
      await tester.testTextInput.receiveAction(TextInputAction.send);
      await tester.pump();

      expect(find.textContaining('Nice place', skipOffstage: false), findsOneWidget);
      expect(tester.widget<TextField>(find.byType(TextField)).controller!.text, isEmpty);
    });

    testWidgets('ignores blank comments', (tester) async {
      cubit = CinemaDetailsCubit()..load();
      await pumpScreen(tester);

      await tester.enterText(find.byType(TextField), '   ');
      await tester.tap(find.byIcon(AppIcons.send));
      await tester.pump();

      expect(_commentCards(), findsNWidgets(3));
    });
  });

  group('CinemaDetailsScreen navigation', () {
    testWidgets('back button pops the screen', (tester) async {
      cubit = CinemaDetailsCubit()..load();
      await tester.pumpAndPush((_) => BlocProvider.value(value: cubit, child: const CinemaDetailsScreen()));
      expect(find.byType(CinemaDetailsScreen), findsOneWidget);

      await tester.tap(find.descendant(of: find.byType(CinemaHeader), matching: find.byType(IconButton)));
      await tester.pumpAndSettle();

      expect(find.byType(CinemaDetailsScreen), findsNothing);
      expect(find.text(hostButtonText), findsOneWidget);
    });
  });

  group('CinemaDetailsScreen localization', () {
    testWidgets('shows Arabic labels and digits', (tester) async {
      cubit = CinemaDetailsCubit()..load();
      await pumpScreen(tester, locale: ar);

      expect(find.text('الأفلام'), findsOneWidget);
      expect(find.textContaining('٤٫٨', findRichText: true), findsOneWidget);
    });
  });
}

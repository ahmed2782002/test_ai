import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../mock_model/home_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  static const Duration bannerInterval = Duration(seconds: 3);
  static const Duration bannerAnimationDuration = Duration(milliseconds: 450);
  static const double bannerViewportFraction = 375 / 390;

  final PageController bannerController = PageController(viewportFraction: bannerViewportFraction);
  final TextEditingController searchController = TextEditingController();
  Timer? _bannerTimer;

  List<QuickActionType> get quickActions => QuickActionType.values;

  double get stepsProgress {
    final home = state.home;
    if (home == null || home.stepsGoal == 0) return 0;
    return (home.todaySteps / home.stepsGoal).clamp(0, 1).toDouble();
  }

  List<double> get weeklyStepsFactors {
    final weekly = state.home?.weeklySteps ?? const <int>[];
    if (weekly.isEmpty) return const [];
    final maxSteps = weekly.reduce(math.max);
    return weekly.map((steps) => maxSteps == 0 ? 0.0 : steps / maxSteps).toList();
  }

  Future<void> loadHome() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final home = await HomeModel.fetch();
      if (isClosed) return;
      emit(state.copyWith(status: HomeStatus.success, home: home));
      startBannerAutoSlide();
    } catch (_) {
      if (isClosed) return;
      emit(state.copyWith(status: HomeStatus.error));
    }
  }

  void startBannerAutoSlide() {
    _bannerTimer?.cancel();
    _bannerTimer = Timer.periodic(bannerInterval, (_) => showNextBanner());
  }

  void showNextBanner() {
    final count = state.home?.banners.length ?? 0;
    if (count < 2 || !bannerController.hasClients) return;
    final next = (bannerController.page?.round() ?? 0) + 1;
    if (next >= count) {
      bannerController.jumpToPage(0);
      return;
    }
    bannerController.animateToPage(next, duration: bannerAnimationDuration, curve: Curves.easeInOut);
  }

  @override
  Future<void> close() {
    _bannerTimer?.cancel();
    bannerController.dispose();
    searchController.dispose();
    return super.close();
  }
}

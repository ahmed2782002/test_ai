import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../mock_model/wheel_prize_model.dart';
import 'spin_wheel_state.dart';

class SpinWheelCubit extends Cubit<SpinWheelState> {
  SpinWheelCubit({Random? random}) : _random = random ?? Random(), super(const SpinWheelState());

  static const int extraTurns = 5;
  static const Duration spinDuration = Duration(seconds: 5);

  final Random _random;

  List<WheelPrizeModel> get prizes => WheelPrizeModel.mock;
  bool get isSpinning => state.status == SpinWheelStatus.spinning;
  WheelPrizeModel? get wonPrize => state.prizeIndex == null ? null : prizes[state.prizeIndex!];

  void spin() {
    if (isSpinning) return;
    final index = _random.nextInt(prizes.length);
    final offset = ((prizes.length - index) % prizes.length) / prizes.length;
    final target = state.turns.ceilToDouble() + extraTurns + offset;
    emit(state.copyWith(status: SpinWheelStatus.spinning, turns: target, prizeIndex: index));
  }

  void completeSpin() {
    if (!isSpinning) return;
    emit(state.copyWith(status: SpinWheelStatus.won));
  }

  void useLater() {
    if (isSpinning) return;
    emit(state.copyWith(status: SpinWheelStatus.useLater));
  }
}

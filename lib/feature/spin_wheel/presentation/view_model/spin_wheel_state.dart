enum SpinWheelStatus { initial, spinning, won, useLater }

class SpinWheelState {
  final SpinWheelStatus status;
  final double turns;
  final int? prizeIndex;

  const SpinWheelState({this.status = SpinWheelStatus.initial, this.turns = 0, this.prizeIndex});

  SpinWheelState copyWith({SpinWheelStatus? status, double? turns, int? prizeIndex}) {
    return SpinWheelState(
      status: status ?? this.status,
      turns: turns ?? this.turns,
      prizeIndex: prizeIndex ?? this.prizeIndex,
    );
  }
}

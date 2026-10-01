import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(const LayoutState());

  static const int homeIndex = 0;

  void selectTab(int index) {
    if (index == state.currentIndex) return;
    emit(LayoutState(currentIndex: index));
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../mock_model/calorie_results_model.dart';
import 'calorie_results_state.dart';

class CalorieResultsCubit extends Cubit<CalorieResultsState> {
  CalorieResultsCubit() : super(const CalorieResultsState());

  void load() {
    emit(state.copyWith(status: CalorieResultsStatus.loading));
    emit(state.copyWith(status: CalorieResultsStatus.success, results: CalorieResultsModel.mock));
  }

  String get formattedDailyCalories => NumberFormat.decimalPattern('en').format(state.results?.dailyCalories ?? 0);
}

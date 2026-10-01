import '../../mock_model/calorie_results_model.dart';

enum CalorieResultsStatus { loading, success, failure }

class CalorieResultsState {
  final CalorieResultsStatus status;
  final CalorieResultsModel? results;

  const CalorieResultsState({this.status = CalorieResultsStatus.loading, this.results});

  CalorieResultsState copyWith({CalorieResultsStatus? status, CalorieResultsModel? results}) {
    return CalorieResultsState(status: status ?? this.status, results: results ?? this.results);
  }
}

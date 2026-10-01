import 'package:flutter_bloc/flutter_bloc.dart';

import '../../mock_model/activity_level_model.dart';
import '../../mock_model/gender.dart';
import '../../mock_model/goal_model.dart';
import 'calorie_calculator_state.dart';

class CalorieCalculatorCubit extends Cubit<CalorieCalculatorState> {
  CalorieCalculatorCubit() : super(const CalorieCalculatorState());

  static const int minWeight = 30;
  static const int maxWeight = 250;
  static const int minHeight = 100;
  static const int maxHeight = 250;
  static const int minAge = 10;
  static const int maxAge = 100;

  List<ActivityLevelModel> get activityLevels => ActivityLevelModel.mock;
  List<GoalModel> get goals => GoalModel.mock;

  bool isGenderSelected(Gender gender) => state.gender == gender;
  bool isActivitySelected(int index) => state.activityIndex == index;
  bool isGoalSelected(int index) => state.goalIndex == index;

  void selectGender(Gender gender) => emit(state.copyWith(gender: gender));
  void selectActivity(int index) => emit(state.copyWith(activityIndex: index));
  void selectGoal(int index) => emit(state.copyWith(goalIndex: index));

  void increaseWeight() => emit(state.copyWith(weight: _clamp(state.weight + 1, minWeight, maxWeight)));
  void decreaseWeight() => emit(state.copyWith(weight: _clamp(state.weight - 1, minWeight, maxWeight)));
  void increaseHeight() => emit(state.copyWith(height: _clamp(state.height + 1, minHeight, maxHeight)));
  void decreaseHeight() => emit(state.copyWith(height: _clamp(state.height - 1, minHeight, maxHeight)));
  void increaseAge() => emit(state.copyWith(age: _clamp(state.age + 1, minAge, maxAge)));
  void decreaseAge() => emit(state.copyWith(age: _clamp(state.age - 1, minAge, maxAge)));

  void calculate() => emit(state.copyWith(status: CalorieCalculatorStatus.submitted));

  int _clamp(int value, int min, int max) => value.clamp(min, max);
}

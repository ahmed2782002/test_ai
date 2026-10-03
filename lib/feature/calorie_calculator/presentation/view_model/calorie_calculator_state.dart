enum Gender { male, female }

enum CalorieCalculatorStatus { initial, submitted }

class CalorieCalculatorState {
  final Gender gender;
  final int weight;
  final int height;
  final int age;
  final int activityIndex;
  final int goalIndex;
  final CalorieCalculatorStatus status;

  const CalorieCalculatorState({
    this.gender = Gender.male,
    this.weight = 80,
    this.height = 175,
    this.age = 28,
    this.activityIndex = 2,
    this.goalIndex = 1,
    this.status = CalorieCalculatorStatus.initial,
  });

  CalorieCalculatorState copyWith({
    Gender? gender,
    int? weight,
    int? height,
    int? age,
    int? activityIndex,
    int? goalIndex,
    CalorieCalculatorStatus? status,
  }) {
    return CalorieCalculatorState(
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      age: age ?? this.age,
      activityIndex: activityIndex ?? this.activityIndex,
      goalIndex: goalIndex ?? this.goalIndex,
      status: status ?? CalorieCalculatorStatus.initial,
    );
  }
}

import 'macro_nutrient_model.dart';
import 'package_model.dart';

class CalorieResultsModel {
  final int dailyCalories;
  final List<MacroNutrientModel> macros;
  final List<PackageModel> packages;

  const CalorieResultsModel({required this.dailyCalories, required this.macros, required this.packages});
}

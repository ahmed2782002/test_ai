import 'localized_text.dart';

class MealModel {
  final int id;
  final LocalizedText name;
  final String image;
  final int calories;
  final int protein;

  const MealModel({required this.id, required this.name, required this.image, required this.calories, required this.protein});
}

import '../../../core/utils/localized_text.dart';

enum PackagePeriod {
  monthly('home.period.monthly'),
  weekly('home.period.weekly');

  final String translationKey;

  const PackagePeriod(this.translationKey);
}

class PackageModel {
  final int id;
  final LocalizedText name;
  final String image;
  final PackagePeriod period;
  final int mealsPerDay;
  final int price;

  const PackageModel({
    required this.id,
    required this.name,
    required this.image,
    required this.period,
    required this.mealsPerDay,
    required this.price,
  });
}

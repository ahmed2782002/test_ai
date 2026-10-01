import 'localized_text.dart';
import 'package_period.dart';

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

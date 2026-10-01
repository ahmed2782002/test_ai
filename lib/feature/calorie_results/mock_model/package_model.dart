import 'package_feature_model.dart';

class PackageModel {
  final String name;
  final String description;
  final String image;
  final int monthlyPrice;
  final bool fitsGoal;
  final List<PackageFeatureModel> features;

  const PackageModel({
    required this.name,
    required this.description,
    required this.image,
    required this.monthlyPrice,
    required this.fitsGoal,
    required this.features,
  });
}

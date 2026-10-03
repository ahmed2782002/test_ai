import 'package:flutter/widgets.dart';

typedef PackageFeature = ({String icon, Size iconSize, String title});

class PackageModel {
  final String name;
  final String description;
  final String image;
  final int monthlyPrice;
  final bool fitsGoal;
  final List<PackageFeature> features;

  const PackageModel({
    required this.name,
    required this.description,
    required this.image,
    required this.monthlyPrice,
    required this.fitsGoal,
    required this.features,
  });
}

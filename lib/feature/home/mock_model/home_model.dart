import 'health_tip_model.dart';
import 'home_banner_model.dart';
import 'home_user_model.dart';
import 'meal_model.dart';
import 'package_model.dart';
import 'steps_model.dart';

class HomeModel {
  final HomeUserModel user;
  final List<HomeBannerModel> banners;
  final MealModel mealOfTheDay;
  final List<PackageModel> suitablePackages;
  final List<PackageModel> mostOrderedPackages;
  final StepsModel steps;
  final HealthTipModel healthTip;

  const HomeModel({
    required this.user,
    required this.banners,
    required this.mealOfTheDay,
    required this.suitablePackages,
    required this.mostOrderedPackages,
    required this.steps,
    required this.healthTip,
  });
}

import '../../../core/utils/app_images.dart';
import 'health_tip_model.dart';
import 'home_banner_model.dart';
import 'home_model.dart';
import 'home_user_model.dart';
import 'localized_text.dart';
import 'meal_model.dart';
import 'package_model.dart';
import 'package_period.dart';
import 'steps_model.dart';

abstract final class HomeMockData {
  static const PackageModel muscleBuildingPackage = PackageModel(
    id: 1,
    name: LocalizedText(ar: 'باقة بناء العضلات', en: 'Muscle Building Package'),
    image: AppImages.testPackageMuscle,
    period: PackagePeriod.monthly,
    mealsPerDay: 3,
    price: 899,
  );

  static const PackageModel healthyKetoPackage = PackageModel(
    id: 2,
    name: LocalizedText(ar: 'باقة الكيتو الصحي', en: 'Healthy Keto Package'),
    image: AppImages.testPackageKeto,
    period: PackagePeriod.weekly,
    mealsPerDay: 2,
    price: 299,
  );

  static const HomeModel home = HomeModel(
    user: HomeUserModel(
      name: LocalizedText(ar: 'أحمد', en: 'Ahmed'),
      avatar: AppImages.testAvatar,
      hasUnreadNotifications: true,
    ),
    banners: [
      HomeBannerModel(id: 1, image: AppImages.testBannerWheel),
      HomeBannerModel(id: 2, image: AppImages.testBannerWheel),
    ],
    mealOfTheDay: MealModel(
      id: 1,
      name: LocalizedText(ar: 'دجاج مشوي مع الأرز البني', en: 'Grilled Chicken with Brown Rice'),
      image: AppImages.testMealGrilledChicken,
      calories: 480,
      protein: 42,
    ),
    suitablePackages: [muscleBuildingPackage, healthyKetoPackage],
    mostOrderedPackages: [muscleBuildingPackage, healthyKetoPackage],
    steps: StepsModel(todaySteps: 6420, goal: 10000, weeklySteps: [2400, 4200, 3000, 4800, 6420]),
    healthTip: HealthTipModel(
      body: LocalizedText(
        ar: 'ابدأ وجبتك بالخضروات لتحسين الشعور بالشبع وضمان امتصاص أفضل للألياف.',
        en: 'Start your meal with vegetables to feel fuller and absorb fiber better.',
      ),
    ),
  );

  static Future<HomeModel> fetchHome() async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    return home;
  }
}

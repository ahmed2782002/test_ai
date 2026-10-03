import '../../../core/utils/app_icons.dart';
import '../../../core/utils/app_images.dart';
import '../../../core/utils/localized_text.dart';
import 'package_model.dart';

enum QuickActionType {
  mySteps(AppIcons.steps, 25.36, 'home.quick_action.my_steps'),
  packages(AppIcons.packages, 23.05, 'home.quick_action.packages'),
  mySubscription(AppIcons.subscription, 33, 'home.quick_action.my_subscription'),
  myOrders(AppIcons.orders, 23.05, 'home.quick_action.my_orders'),
  orderMeal(AppIcons.orderMeal, 23.05, 'home.quick_action.order_meal');

  final String icon;
  final double iconHeight;
  final String translationKey;

  const QuickActionType(this.icon, this.iconHeight, this.translationKey);
}

class HomeModel {
  final LocalizedText userName;
  final String userAvatar;
  final bool hasUnreadNotifications;
  final List<String> banners;
  final LocalizedText mealName;
  final String mealImage;
  final int mealCalories;
  final int mealProtein;
  final List<PackageModel> suitablePackages;
  final List<PackageModel> mostOrderedPackages;
  final int todaySteps;
  final int stepsGoal;
  final List<int> weeklySteps;
  final LocalizedText healthTip;

  const HomeModel({
    required this.userName,
    required this.userAvatar,
    required this.hasUnreadNotifications,
    required this.banners,
    required this.mealName,
    required this.mealImage,
    required this.mealCalories,
    required this.mealProtein,
    required this.suitablePackages,
    required this.mostOrderedPackages,
    required this.todaySteps,
    required this.stepsGoal,
    required this.weeklySteps,
    required this.healthTip,
  });

  static const List<PackageModel> _mockPackages = [
    PackageModel(
      id: 1,
      name: LocalizedText(ar: 'باقة بناء العضلات', en: 'Muscle Building Package'),
      image: AppImages.testPackageMuscle,
      period: PackagePeriod.monthly,
      mealsPerDay: 3,
      price: 899,
    ),
    PackageModel(
      id: 2,
      name: LocalizedText(ar: 'باقة الكيتو الصحي', en: 'Healthy Keto Package'),
      image: AppImages.testPackageKeto,
      period: PackagePeriod.weekly,
      mealsPerDay: 2,
      price: 299,
    ),
  ];

  static const HomeModel mock = HomeModel(
    userName: LocalizedText(ar: 'أحمد', en: 'Ahmed'),
    userAvatar: AppImages.testAvatar,
    hasUnreadNotifications: true,
    banners: [AppImages.testBannerWheel, AppImages.testBannerWheel],
    mealName: LocalizedText(ar: 'دجاج مشوي مع الأرز البني', en: 'Grilled Chicken with Brown Rice'),
    mealImage: AppImages.testMealGrilledChicken,
    mealCalories: 480,
    mealProtein: 42,
    suitablePackages: _mockPackages,
    mostOrderedPackages: _mockPackages,
    todaySteps: 6420,
    stepsGoal: 10000,
    weeklySteps: [2400, 4200, 3000, 4800, 6420],
    healthTip: LocalizedText(
      ar: 'ابدأ وجبتك بالخضروات لتحسين الشعور بالشبع وضمان امتصاص أفضل للألياف.',
      en: 'Start your meal with vegetables to feel fuller and absorb fiber better.',
    ),
  );

  static Future<HomeModel> fetch() async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    return mock;
  }
}

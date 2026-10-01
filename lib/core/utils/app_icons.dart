import 'package:flutter/material.dart';

abstract final class AppIcons {
  static const String _common = 'assets/icons/common';
  static const String _calculator = 'assets/icons/calorie_calculator';
  static const String _results = 'assets/icons/calorie_results';
  static const String _home = 'assets/icons/home';
  static const String _navBar = 'assets/icons/nav_bar';

  static const String back = '$_common/back.svg';
  static const String checkCircle = '$_common/check_circle.svg';

  static const String user = '$_calculator/user.svg';
  static const String male = '$_calculator/male.svg';
  static const String female = '$_calculator/female.svg';
  static const String sedentary = '$_calculator/activity_sedentary.svg';
  static const String light = '$_calculator/activity_light.svg';
  static const String moderate = '$_calculator/activity_moderate.svg';
  static const String loseWeight = '$_calculator/goal_lose.svg';
  static const String maintainWeight = '$_calculator/goal_maintain.svg';
  static const String gainWeight = '$_calculator/goal_gain.svg';

  static const String proteinPlate = '$_results/macro_protein.svg';
  static const String carbs = '$_results/macro_carbs.svg';
  static const String fats = '$_results/macro_fats.svg';
  static const String goalTarget = '$_results/fits_goal.svg';
  static const String meals = '$_results/benefit_meals.svg';
  static const String delivery = '$_results/benefit_delivery.svg';
  static const String nutritionist = '$_results/benefit_consultation.svg';
  static const String packagesStar = '$_results/star.svg';

  static const String notification = '$_home/bell.svg';
  static const String search = '$_home/search.svg';
  static const String calories = '$_home/flame.svg';
  static const String protein = '$_home/egg.svg';
  static const String tip = '$_home/lightbulb.svg';
  static const String stepsRing = '$_home/steps_ring.svg';
  static const String orderMeal = '$_home/quick_order_meal.svg';
  static const String orders = '$_home/quick_orders.svg';
  static const String subscription = '$_home/quick_subscription.svg';
  static const String packages = '$_home/quick_packages.svg';
  static const String steps = '$_home/quick_steps.svg';

  static const String navHome = '$_navBar/home.svg';
  static const String navOrders = '$_navBar/orders.svg';
  static const String navCalories = '$_navBar/calories.svg';
  static const String navMeals = '$_navBar/meals.svg';
  static const String navAccount = '$_navBar/account.svg';

  static const IconData active = Icons.directions_run;
  static const IconData veryActive = Icons.bolt;
  static const IconData plus = Icons.add;
  static const IconData minus = Icons.remove;
  static const IconData check = Icons.check;
  static const IconData forward = Icons.arrow_forward_rounded;
  static const IconData retry = Icons.refresh_rounded;
  static const IconData star = Icons.star_rounded;
  static const IconData gift = Icons.card_giftcard;
  static const IconData discountTag = Icons.sell;
  static const IconData surpriseGift = Icons.local_drink;
  static const IconData dietPlan = Icons.dinner_dining;
  static const IconData consultation = Icons.straighten;
  static const IconData percentTag = Icons.discount;
  static const IconData extraMeal = Icons.room_service;
  static const IconData wheelPointer = Icons.location_on;
  static const IconData chevronForward = Icons.arrow_forward_ios;
  static const IconData starSharp = Icons.star;
  static const IconData duration = Icons.access_time;
  static const IconData genre = Icons.videocam_outlined;
  static const IconData send = Icons.send;
}

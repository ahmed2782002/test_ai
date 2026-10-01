import '../../../core/utils/app_icons.dart';

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

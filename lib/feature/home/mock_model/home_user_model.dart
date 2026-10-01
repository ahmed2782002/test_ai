import 'localized_text.dart';

class HomeUserModel {
  final LocalizedText name;
  final String avatar;
  final bool hasUnreadNotifications;

  const HomeUserModel({required this.name, required this.avatar, required this.hasUnreadNotifications});
}

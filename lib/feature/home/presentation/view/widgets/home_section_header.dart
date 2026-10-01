import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_text.dart';

class HomeSectionHeader extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final VoidCallback onViewAll;

  const HomeSectionHeader({super.key, required this.title, this.titleStyle, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: titleStyle ?? AppText.homeHeadline, maxLines: 1, overflow: TextOverflow.ellipsis)),
        GestureDetector(onTap: onViewAll, child: Text(context.tr('home.view_all'), style: AppText.link)),
      ],
    );
  }
}

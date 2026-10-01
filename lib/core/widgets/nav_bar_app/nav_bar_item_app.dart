import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_text.dart';
import '../app_svg_icon/app_svg_icon.dart';
import 'nav_bar_item_data.dart';

class NavBarItemApp extends StatelessWidget {
  final NavBarItemData item;
  final bool isSelected;
  final VoidCallback onTap;

  const NavBarItemApp({super.key, required this.item, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.only(top: 14.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 25.r,
              child: Center(child: AppSvgIcon(asset: item.icon, height: item.iconHeight.r)),
            ),
            SizedBox(height: 6.h),
            Text(item.label, style: AppText.navLabel, maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

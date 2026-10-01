import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_radius.dart';
import '../../theme/app_text.dart';
import 'nav_bar_center_button_app.dart';
import 'nav_bar_item_app.dart';
import 'nav_bar_item_data.dart';
import 'nav_bar_shape_painter.dart';

class NavBarApp extends StatelessWidget {
  final List<NavBarItemData> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const NavBarApp({super.key, required this.items, required this.currentIndex, required this.onTap});

  int get centerIndex => items.length ~/ 2;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final fabSize = 64.r;
    final fabOverflow = 22.h;
    final barHeight = 83.h + bottomInset;
    return SizedBox(
      height: barHeight + fabOverflow,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            top: fabOverflow,
            child: CustomPaint(
              painter: NavBarShapePainter(
                fabCenterY: fabSize / 2 - fabOverflow,
                notchRadius: fabSize / 2 + 6.r,
                cornerRadius: AppRadius.medium,
              ),
            ),
          ),
          Positioned.fill(
            top: fabOverflow,
            bottom: bottomInset,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var index = 0; index < items.length; index++)
                  Expanded(
                    child: index == centerIndex
                        ? GestureDetector(
                            onTap: () => onTap(index),
                            child: Padding(
                              padding: EdgeInsets.only(top: 52.h),
                              child: Text(
                                items[index].label,
                                style: AppText.navLabel,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                        : NavBarItemApp(item: items[index], isSelected: index == currentIndex, onTap: () => onTap(index)),
                  ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: NavBarCenterButtonApp(icon: items[centerIndex].icon, size: fabSize, onTap: () => onTap(centerIndex)),
          ),
        ],
      ),
    );
  }
}

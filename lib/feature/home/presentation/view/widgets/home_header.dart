import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/widgets/app_svg_icon/app_svg_icon.dart';

class HomeHeader extends StatelessWidget {
  final String name;
  final String avatar;
  final bool hasUnreadNotifications;
  final VoidCallback onNotificationTap;

  const HomeHeader({
    super.key,
    required this.name,
    required this.avatar,
    required this.hasUnreadNotifications,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44.r,
          height: 44.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.white, width: 2.r),
            image: DecorationImage(image: AssetImage(avatar), fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr('home.greeting', namedArgs: {'name': name}),
                style: AppText.homeGreeting,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 6.h),
              Text(
                context.tr('home.greeting_subtitle'),
                style: AppText.grayCaption,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        GestureDetector(
          onTap: onNotificationTap,
          child: Container(
            width: 40.r,
            height: 40.r,
            decoration: const BoxDecoration(color: AppColors.white, shape: BoxShape.circle, boxShadow: AppShadows.homeCard),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AppSvgIcon(asset: AppIcons.notification, width: 20.r, height: 20.r),
                if (hasUnreadNotifications)
                  PositionedDirectional(
                    top: 9.r,
                    end: 10.r,
                    child: Container(
                      width: 8.r,
                      height: 8.r,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 1.r),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

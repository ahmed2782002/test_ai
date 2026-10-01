import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/widgets/app_primary_button/app_primary_button.dart';

class HomeErrorView extends StatelessWidget {
  final String? message;
  final VoidCallback onRetry;

  const HomeErrorView({super.key, this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(AppIcons.retry, size: 48.r, color: AppColors.textGray),
            SizedBox(height: 16.h),
            Text(message ?? context.tr('home.error_message'), style: AppText.homeLabel, textAlign: TextAlign.center),
            SizedBox(height: 24.h),
            AppPrimaryButton(text: context.tr('home.retry'), onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}

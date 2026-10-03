import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text.dart';
import '../app_primary_button/app_primary_button.dart';

class AppErrorView extends StatelessWidget {
  final String message;
  final String retryText;
  final VoidCallback onRetry;
  final TextStyle? messageStyle;
  final IconData? icon;

  const AppErrorView({
    super.key,
    required this.message,
    required this.retryText,
    required this.onRetry,
    this.messageStyle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 48.r, color: AppColors.textGray),
              SizedBox(height: 16.h),
            ],
            Text(message, style: messageStyle ?? AppText.subtitle, textAlign: TextAlign.center),
            SizedBox(height: 16.h),
            AppPrimaryButton(text: retryText, onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}

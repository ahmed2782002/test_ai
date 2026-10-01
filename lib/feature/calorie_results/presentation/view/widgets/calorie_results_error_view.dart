import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text.dart';
import '../../../../../core/widgets/app_primary_button/app_primary_button.dart';

class CalorieResultsErrorView extends StatelessWidget {
  final String message;
  final String retryText;
  final VoidCallback onRetry;

  const CalorieResultsErrorView({super.key, required this.message, required this.retryText, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, style: AppText.subtitle, textAlign: TextAlign.center),
            SizedBox(height: 16.h),
            AppPrimaryButton(text: retryText, onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}

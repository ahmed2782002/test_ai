import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/widgets/app_primary_button/app_primary_button.dart';

class CalculateBottomBar extends StatelessWidget {
  final String buttonText;
  final String hint;
  final VoidCallback onPressed;

  const CalculateBottomBar({
    super.key,
    required this.buttonText,
    required this.hint,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
      decoration: BoxDecoration(
        color: AppColors.bottomBar,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.large)),
        boxShadow: AppShadows.bottomBar,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppPrimaryButton(text: buttonText, onPressed: onPressed, shadow: AppShadows.button),
            SizedBox(height: 12.h),
            Text(hint, style: AppText.caption, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_text.dart';

class AppPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? trailingIcon;
  final double? borderRadius;
  final TextStyle? textStyle;
  final List<BoxShadow>? shadow;
  final double? trailingIconSize;

  const AppPrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.trailingIcon,
    this.borderRadius,
    this.textStyle,
    this.shadow,
    this.trailingIconSize,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius ?? AppRadius.small);
    final style = textStyle ?? AppText.button;
    return Container(
      width: double.infinity,
      height: 52.h,
      decoration: BoxDecoration(borderRadius: radius, boxShadow: shadow),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: radius),
        ),
        child: trailingIcon == null
            ? Text(text, style: style)
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(child: Text(text, style: style, overflow: TextOverflow.ellipsis)),
                  SizedBox(width: 8.w),
                  Icon(trailingIcon, size: trailingIconSize ?? 20.r, color: style.color),
                ],
              ),
      ),
    );
  }
}

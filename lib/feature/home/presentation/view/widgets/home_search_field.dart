import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/widgets/app_svg_icon/app_svg_icon.dart';

class HomeSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onSubmitted;

  const HomeSearchField({super.key, required this.controller, required this.hint, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.medium),
      borderSide: BorderSide.none,
    );
    return Container(
      height: 51.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        boxShadow: AppShadows.mutedCard,
      ),
      child: TextField(
        controller: controller,
        onSubmitted: onSubmitted,
        textInputAction: TextInputAction.search,
        style: AppText.homeLabel,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppText.searchHint,
          filled: true,
          fillColor: AppColors.white,
          isCollapsed: true,
          contentPadding: EdgeInsetsDirectional.only(start: 16.w, end: 8.w),
          suffixIcon: Center(
            widthFactor: 1,
            heightFactor: 1,
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: 8.w, end: 16.w),
              child: AppSvgIcon(asset: AppIcons.search, width: 18.r, height: 24.48.r),
            ),
          ),
          border: border,
          enabledBorder: border,
          focusedBorder: border,
        ),
      ),
    );
  }
}

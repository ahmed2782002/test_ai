import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_icons.dart';

class CounterField extends StatelessWidget {
  final int value;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CounterField({
    super.key,
    required this.value,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: BoxDecoration(
        color: AppColors.fieldBackground,
        borderRadius: BorderRadius.circular(AppRadius.small),
        border: Border.all(color: AppColors.fieldBorder),
      ),
      child: Row(
        children: [
          _buildActionButton(AppIcons.plus, onIncrease),
          Expanded(
            child: Text('$value', textAlign: TextAlign.center, style: AppText.counterValue),
          ),
          _buildActionButton(AppIcons.minus, onDecrease),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32.r,
        height: 32.r,
        decoration: const BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          boxShadow: AppShadows.option,
        ),
        child: Icon(icon, size: 16.r, color: AppColors.primary),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_shadows.dart';

class CounterActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const CounterActionButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
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

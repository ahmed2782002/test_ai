import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/widgets/app_icon_circle/app_icon_circle.dart';
import '../../../mock_model/package_model.dart';

class PackageFeatureRow extends StatelessWidget {
  final PackageFeature feature;

  const PackageFeatureRow({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppIconCircle(
          icon: feature.icon,
          size: 32.r,
          iconWidth: feature.iconSize.width.r,
          iconHeight: feature.iconSize.height.r,
          backgroundColor: AppColors.iconCircle,
        ),
        SizedBox(width: 12.w),
        Expanded(child: Text(feature.title.tr(context: context), style: AppText.bodyMedium)),
      ],
    );
  }
}

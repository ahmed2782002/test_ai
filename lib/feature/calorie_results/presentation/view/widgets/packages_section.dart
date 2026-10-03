import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/widgets/app_svg_icon/app_svg_icon.dart';
import '../../../mock_model/package_model.dart';
import 'package_card.dart';

class PackagesSection extends StatelessWidget {
  final List<PackageModel> packages;
  final VoidCallback onViewAll;
  final VoidCallback onSubscribe;

  const PackagesSection({super.key, required this.packages, required this.onViewAll, required this.onSubscribe});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            AppSvgIcon(asset: AppIcons.packagesStar, width: 20.r, height: 19.r),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'calorie_results.packages_title'.tr(context: context),
                style: AppText.packagesTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            GestureDetector(
              onTap: onViewAll,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Text('calorie_results.view_all'.tr(context: context), style: AppText.link),
              ),
            ),
          ],
        ),
        SizedBox(height: 18.h),
        for (final package in packages) ...[
          PackageCard(package: package, onSubscribe: onSubscribe),
          SizedBox(height: 16.h),
        ],
      ],
    );
  }
}

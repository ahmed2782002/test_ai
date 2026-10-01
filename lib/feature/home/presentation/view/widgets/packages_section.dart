import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../mock_model/package_model.dart';
import 'home_section_header.dart';
import 'package_card.dart';

class PackagesSection extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final List<PackageModel> packages;
  final VoidCallback onViewAll;
  final ValueChanged<PackageModel> onPackageTap;

  const PackagesSection({
    super.key,
    required this.title,
    this.titleStyle,
    required this.packages,
    required this.onViewAll,
    required this.onPackageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: HomeSectionHeader(title: title, titleStyle: titleStyle, onViewAll: onViewAll),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.fromLTRB(15.w, 12.h, 15.w, 26.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var index = 0; index < packages.length; index++)
                Padding(
                  padding: EdgeInsetsDirectional.only(start: index == 0 ? 0 : 12.w),
                  child: PackageCard(package: packages[index], onTap: () => onPackageTap(packages[index])),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

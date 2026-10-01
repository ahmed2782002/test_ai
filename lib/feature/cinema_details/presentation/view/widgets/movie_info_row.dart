import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text.dart';

class MovieInfoRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;

  const MovieInfoRow({super.key, required this.icon, required this.iconColor, required this.text});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 22.h),
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: 2.w),
        child: Row(
          children: [
            Icon(icon, size: 17.r, color: iconColor),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(text, style: AppText.movieInfo, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}

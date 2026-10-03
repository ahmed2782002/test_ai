import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_bidi.dart';
import '../../../mock_model/cinema_model.dart';

class CommentCard extends StatelessWidget {
  final CommentModel comment;

  const CommentCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 59.h),
      padding: EdgeInsetsDirectional.fromSTEB(1.w, 1.h, 12.w, 6.h),
      decoration: BoxDecoration(
        color: AppColors.cinemaCard,
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: ClipOval(
              child: Image.asset(comment.avatar, width: 40.r, height: 40.r, fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 11.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppBidi.isolate(comment.username),
                  style: AppText.commentUsername,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(AppBidi.isolate(comment.text), style: AppText.commentBody),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

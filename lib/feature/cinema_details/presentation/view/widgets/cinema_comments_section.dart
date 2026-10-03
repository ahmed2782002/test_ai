import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text.dart';
import '../../../mock_model/cinema_model.dart';
import 'comment_card.dart';

class CinemaCommentsSection extends StatelessWidget {
  final String title;
  final List<CommentModel> comments;

  const CinemaCommentsSection({super.key, required this.title, required this.comments});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 9.w),
          child: Text(title, style: AppText.cinemaSectionTitleLight),
        ),
        SizedBox(height: 15.h),
        for (final comment in comments)
          Padding(
            padding: EdgeInsetsDirectional.only(start: 10.w, end: 37.w, bottom: 22.h),
            child: CommentCard(comment: comment),
          ),
      ],
    );
  }
}

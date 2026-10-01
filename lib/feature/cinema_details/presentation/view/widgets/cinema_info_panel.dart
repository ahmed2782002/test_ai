import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_bidi.dart';
import '../../../../../core/utils/app_icons.dart';

class CinemaInfoPanel extends StatelessWidget {
  final String name;
  final String description;
  final String reviewLabel;
  final String rating;
  final String reviewsCount;
  final int filledStars;
  final int starsCount;

  const CinemaInfoPanel({
    super.key,
    required this.name,
    required this.description,
    required this.reviewLabel,
    required this.rating,
    required this.reviewsCount,
    required this.filledStars,
    required this.starsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.cinemaPanel,
      padding: EdgeInsetsDirectional.fromSTEB(12.w, 8.h, 8.w, 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: '${AppBidi.isolate(name)}:   ', style: AppText.cinemaName),
                TextSpan(text: AppBidi.isolate(description), style: AppText.cinemaDescription),
              ],
            ),
          ),
          SizedBox(height: 26.h),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 4.w),
            child: Row(
              children: [
                Text(reviewLabel, style: AppText.cinemaReviewLabel),
                SizedBox(width: 8.w),
                Icon(AppIcons.starSharp, size: 18.r, color: AppColors.ratingStar),
                SizedBox(width: 4.w),
                Flexible(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: '$rating ', style: AppText.cinemaRating),
                        TextSpan(text: reviewsCount, style: AppText.cinemaRatingCount),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 14.w),
            child: Row(
              children: [
                for (var index = 0; index < starsCount; index++)
                  Padding(
                    padding: EdgeInsetsDirectional.only(end: index == starsCount - 1 ? 0 : 8.w),
                    child: Icon(
                      AppIcons.starSharp,
                      size: 36.r,
                      color: index < filledStars ? AppColors.cinemaStar : AppColors.cinemaStarInactive,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

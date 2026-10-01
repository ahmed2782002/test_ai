import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_text.dart';
import '../../../../../core/utils/app_bidi.dart';
import '../../../../../core/utils/app_icons.dart';
import 'movie_info_row.dart';

class MovieCard extends StatelessWidget {
  final String poster;
  final String title;
  final String rating;
  final String duration;
  final String genres;

  const MovieCard({
    super.key,
    required this.poster,
    required this.title,
    required this.rating,
    required this.duration,
    required this.genres,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = AppText.movieTitle;
    final titleHeight = MediaQuery.textScalerOf(context).scale(titleStyle.fontSize!) * titleStyle.height! * 2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.compact),
          child: AspectRatio(
            aspectRatio: 176 / 265,
            child: Image.asset(poster, fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: 6.h),
        SizedBox(
          height: titleHeight,
          child: Text(AppBidi.isolate(title), style: titleStyle, maxLines: 2, overflow: TextOverflow.ellipsis),
        ),
        SizedBox(height: 5.h),
        MovieInfoRow(icon: AppIcons.starSharp, iconColor: AppColors.ratingStar, text: rating),
        MovieInfoRow(icon: AppIcons.duration, iconColor: AppColors.cinemaIcon, text: duration),
        MovieInfoRow(icon: AppIcons.genre, iconColor: AppColors.cinemaIcon, text: AppBidi.isolate(genres)),
      ],
    );
  }
}

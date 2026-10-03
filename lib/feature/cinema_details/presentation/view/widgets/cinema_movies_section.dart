import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text.dart';
import '../../../mock_model/movie_model.dart';
import 'movie_card.dart';

class CinemaMoviesSection extends StatelessWidget {
  final String title;
  final List<MovieModel> movies;
  final String Function(MovieModel movie) ratingOf;
  final String Function(MovieModel movie) durationOf;

  const CinemaMoviesSection({
    super.key,
    required this.title,
    required this.movies,
    required this.ratingOf,
    required this.durationOf,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 17.w),
          child: Text(title, style: AppText.cinemaSectionTitle),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 16.w, end: 12.w),
          child: LayoutBuilder(
            builder: (context, constraints) => Wrap(
              spacing: 14.w,
              runSpacing: 24.h,
              children: [
                for (final movie in movies)
                  SizedBox(
                    width: (constraints.maxWidth - 14.w) / 2,
                    child: MovieCard(movie: movie, rating: ratingOf(movie), duration: durationOf(movie)),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

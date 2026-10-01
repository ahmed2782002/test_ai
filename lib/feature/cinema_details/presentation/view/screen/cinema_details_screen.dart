import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text.dart';
import '../../view_model/cinema_details_cubit.dart';
import '../../view_model/cinema_details_state.dart';
import '../widgets/add_comment_bar.dart';
import '../widgets/cinema_details_error_view.dart';
import '../widgets/cinema_details_shimmer.dart';
import '../widgets/cinema_header.dart';
import '../widgets/cinema_info_panel.dart';
import '../widgets/comment_card.dart';
import '../widgets/movie_card.dart';

class CinemaDetailsScreen extends StatelessWidget {
  const CinemaDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CinemaDetailsCubit>();
    final languageCode = context.locale.languageCode;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.cinemaBackground,
        body: BlocBuilder<CinemaDetailsCubit, CinemaDetailsState>(
          builder: (context, state) {
            final cinema = state.cinema;
            if (state.status == CinemaDetailsStatus.loading) {
              return const CinemaDetailsShimmer();
            }
            if (state.status == CinemaDetailsStatus.failure || cinema == null) {
              return SafeArea(
                child: CinemaDetailsErrorView(
                  message: 'cinema_details.error'.tr(context: context),
                  retryText: 'cinema_details.retry'.tr(context: context),
                  onRetry: cubit.load,
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 6.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CinemaHeader(
                          image: cinema.image,
                          onBack: () => Navigator.maybePop(context),
                          panel: CinemaInfoPanel(
                            name: cinema.name,
                            description: cinema.description,
                            reviewLabel: 'cinema_details.review'.tr(context: context),
                            rating: cubit.rating(cinema.rating, languageCode),
                            reviewsCount: cubit.reviewsCount(cinema.reviewsCount, languageCode),
                            filledStars: cubit.filledStars,
                            starsCount: CinemaDetailsCubit.starsCount,
                          ),
                        ),
                        SizedBox(height: 26.h),
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 17.w),
                          child: Text('cinema_details.movies'.tr(context: context), style: AppText.cinemaSectionTitle),
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 16.w, end: 12.w),
                          child: LayoutBuilder(
                            builder: (context, constraints) => Wrap(
                              spacing: 14.w,
                              runSpacing: 24.h,
                              children: [
                                for (final movie in cinema.movies)
                                  SizedBox(
                                    width: (constraints.maxWidth - 14.w) / 2,
                                    child: MovieCard(
                                      poster: movie.poster,
                                      title: movie.title,
                                      rating:
                                          '${cubit.rating(movie.rating, languageCode)} ${cubit.reviewsCount(movie.reviewsCount, languageCode)}',
                                      duration: 'cinema_details.duration'.tr(
                                        context: context,
                                        args: [
                                          cubit.hours(movie.durationMinutes, languageCode),
                                          cubit.minutes(movie.durationMinutes, languageCode),
                                        ],
                                      ),
                                      genres: movie.genres,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 32.h),
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 9.w),
                          child: Text(
                            'cinema_details.comments'.tr(context: context),
                            style: AppText.cinemaSectionTitleLight,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        for (final comment in state.comments)
                          Padding(
                            padding: EdgeInsetsDirectional.only(start: 10.w, end: 37.w, bottom: 22.h),
                            child: CommentCard(avatar: comment.avatar, username: comment.username, text: comment.text),
                          ),
                      ],
                    ),
                  ),
                ),
                AddCommentBar(
                  controller: cubit.commentController,
                  hint: 'cinema_details.add_comment'.tr(context: context),
                  onSend: cubit.sendComment,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

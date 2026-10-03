import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_digits.dart';
import '../../mock_model/cinema_model.dart';
import 'cinema_details_state.dart';

class CinemaDetailsCubit extends Cubit<CinemaDetailsState> {
  CinemaDetailsCubit() : super(const CinemaDetailsState());

  static const int starsCount = 5;

  final TextEditingController commentController = TextEditingController();

  Future<void> load() async {
    emit(state.copyWith(status: CinemaDetailsStatus.loading));
    try {
      final cinema = await CinemaModel.fetch();
      if (isClosed) return;
      emit(state.copyWith(status: CinemaDetailsStatus.success, cinema: cinema, comments: cinema.comments));
    } catch (_) {
      if (!isClosed) emit(state.copyWith(status: CinemaDetailsStatus.failure));
    }
  }

  int get filledStars => (state.cinema?.rating ?? 0).floor().clamp(0, starsCount);

  String rating(double value, String languageCode) => AppDigits.decimal(value, languageCode);

  String reviewsCount(int value, String languageCode) => '(${AppDigits.format(value, languageCode)})';

  String hours(int minutes, String languageCode) => AppDigits.format(minutes ~/ 60, languageCode);

  String minutes(int minutes, String languageCode) => AppDigits.format(minutes % 60, languageCode);

  void sendComment() {
    final text = commentController.text.trim();
    if (text.isEmpty) return;
    final CommentModel comment = (
      username: CinemaModel.currentUsername,
      avatar: CinemaModel.currentUserAvatar,
      text: text,
    );
    commentController.clear();
    emit(state.copyWith(comments: [...state.comments, comment]));
  }

  @override
  Future<void> close() {
    commentController.dispose();
    return super.close();
  }
}

import '../../mock_model/cinema_model.dart';
import '../../mock_model/comment_model.dart';

enum CinemaDetailsStatus { loading, success, failure }

class CinemaDetailsState {
  final CinemaDetailsStatus status;
  final CinemaModel? cinema;
  final List<CommentModel> comments;

  const CinemaDetailsState({this.status = CinemaDetailsStatus.loading, this.cinema, this.comments = const []});

  CinemaDetailsState copyWith({CinemaDetailsStatus? status, CinemaModel? cinema, List<CommentModel>? comments}) {
    return CinemaDetailsState(
      status: status ?? this.status,
      cinema: cinema ?? this.cinema,
      comments: comments ?? this.comments,
    );
  }
}

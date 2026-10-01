import 'comment_model.dart';
import 'movie_model.dart';

class CinemaModel {
  final String name;
  final String description;
  final String image;
  final double rating;
  final int reviewsCount;
  final List<MovieModel> movies;
  final List<CommentModel> comments;

  const CinemaModel({
    required this.name,
    required this.description,
    required this.image,
    required this.rating,
    required this.reviewsCount,
    required this.movies,
    required this.comments,
  });
}

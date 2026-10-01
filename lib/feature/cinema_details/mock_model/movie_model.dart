class MovieModel {
  final String title;
  final String poster;
  final double rating;
  final int reviewsCount;
  final int durationMinutes;
  final String genres;

  const MovieModel({
    required this.title,
    required this.poster,
    required this.rating,
    required this.reviewsCount,
    required this.durationMinutes,
    required this.genres,
  });
}

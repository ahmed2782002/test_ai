import '../../../core/utils/app_images.dart';
import 'cinema_model.dart';
import 'comment_model.dart';
import 'movie_model.dart';

abstract final class CinemaDetailsMock {
  static const String currentUsername = '@me';
  static const String currentUserAvatar = AppImages.testAvatar;

  static const CinemaModel data = CinemaModel(
    name: 'IMAX cinema',
    description:
        'StatUp is planned for 2025, type of theater known for its large screen size and high-quality sound system. It offers an immersive viewing experience for movies, documentaries, and other content',
    image: AppImages.testCinemaImax,
    rating: 4.8,
    reviewsCount: 1222,
    movies: [
      MovieModel(
        title: 'Shazam: Fury of the Gods',
        poster: AppImages.testMovieShazam,
        rating: 4.0,
        reviewsCount: 982,
        durationMinutes: 125,
        genres: 'Action, Sci-fi',
      ),
      MovieModel(
        title: 'Avengers: Infinity War',
        poster: AppImages.testMovieAvengers,
        rating: 4.0,
        reviewsCount: 982,
        durationMinutes: 125,
        genres: 'Action, Sci-fi',
      ),
    ],
    comments: [
      CommentModel(
        username: '@Iva588',
        avatar: AppImages.testAvatarIva,
        text: 'Great selection of movies . Highly recommended!',
      ),
      CommentModel(
        username: '@Rana158',
        avatar: AppImages.testAvatarRana,
        text: 'The luxurious seats and immersive sound system make for a truly unforgettable',
      ),
      CommentModel(
        username: '@Mahmoud',
        avatar: AppImages.testAvatarMahmoud,
        text: "The cinema's modern design and aesthetically pleasing decor create a welcoming atmosphere",
      ),
    ],
  );
}

import 'package:movies_domain/models/movie_info.dart';

class Movie {
  final int id;
  final String title;
  final String posterPath;
  final MovieInfo? info;

  const Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    this.info,
  });
}

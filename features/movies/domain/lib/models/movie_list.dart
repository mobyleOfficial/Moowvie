import 'package:movies_domain/models/movie.dart';
import 'package:movies_domain/models/movie_list_info.dart';

class MovieList {
  final int id;
  final String name;
  final String creator;
  final String description;
  final List<Movie> movies;
  final MovieListInfo? info;

  const MovieList({
    required this.id,
    required this.name,
    required this.creator,
    required this.description,
    this.movies = const [],
    this.info,
  });
}

import 'package:movies_domain/domain.dart';

class RemoteMovieCollection {
  final String title;
  final int movieCount;

  const RemoteMovieCollection({
    required this.title,
    required this.movieCount,
  });

  factory RemoteMovieCollection.fromJson(Map<String, dynamic> json) =>
      RemoteMovieCollection(
        title: json['title'] as String,
        movieCount: json['movie_count'] as int,
      );

  MovieCollection toDomain() => MovieCollection(
        title: title,
        movieCount: movieCount,
      );
}

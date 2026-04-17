import 'package:movies_domain/models/movie.dart';
import 'package:movies_domain/models/movie_review.dart';
import 'package:movies_domain/models/watch_provider.dart';

class MovieInfo {
  final String overview;
  final String backdropPath;
  final double voteAverage;
  final String releaseDate;
  final String tagline;
  final int runtime;
  final List<String> genres;
  final String director;
  final List<String> cast;
  final List<WatchProvider> watchProviders;
  final List<Movie> similarMovies;
  final List<MovieReview> popularReviews;
  final int reviewCount;
  final int listCount;
  final int likeCount;

  const MovieInfo({
    required this.overview,
    required this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
    this.tagline = '',
    this.runtime = 0,
    this.genres = const [],
    this.director = '',
    this.cast = const [],
    this.watchProviders = const [],
    this.similarMovies = const [],
    this.popularReviews = const [],
    this.reviewCount = 0,
    this.listCount = 0,
    this.likeCount = 0,
  });
}

import 'package:movies_domain/models/movie.dart';
import 'package:movies_domain/models/movie_review.dart';
import 'package:movies_domain/models/watch_provider.dart';

class MovieInfo {
  final String overview;
  final String backdropPath;
  final double voteAverage;
  final String releaseDate;
  final String? tagline;
  final int? runtime;
  final List<String>? genres;
  final String? director;
  final List<String>? cast;
  final List<WatchProvider>? watchProviders;
  final List<Movie>? similarMovies;
  final List<MovieReview>? popularReviews;
  final int? reviewCount;
  final int? listCount;
  final int? likeCount;

  const MovieInfo({
    required this.overview,
    required this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
    this.tagline,
    this.runtime,
    this.genres,
    this.director,
    this.cast,
    this.watchProviders,
    this.similarMovies,
    this.popularReviews,
    this.reviewCount,
    this.listCount,
    this.likeCount,
  });
}

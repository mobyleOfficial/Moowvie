import 'package:movies_domain/models/popular_review.dart';
import 'package:movies_domain/models/watch_provider.dart';

class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
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
  final List<PopularReview>? popularReviews;
  final int? reviewCount;
  final int? listCount;
  final int? likeCount;

  const Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
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

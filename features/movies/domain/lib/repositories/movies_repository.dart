import 'package:core/core.dart';

import 'package:movies_domain/models/movie_detail.dart';
import 'package:movies_domain/models/trending_movie_listing.dart';

abstract interface class MoviesRepository {
  Future<Result<TrendingMovieListing>> getTrendingMovieList({required int page});
  Future<Result<MovieDetail>> getMovieDetail({required int movieId});
}

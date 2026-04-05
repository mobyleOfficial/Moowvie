import 'package:injectable/injectable.dart';
import 'package:movies_domain/domain.dart';

@module
abstract class MoviesDiModule {
  @lazySingleton
  GetTrendingMovies getTrendingMovies(MoviesRepository moviesRepository) =>
      GetTrendingMovies(moviesRepository);

  @lazySingleton
  GetMovieReviews getMovieReviews(MoviesRepository moviesRepository) =>
      GetMovieReviews(moviesRepository);

  @lazySingleton
  GetMovieCollections getMovieCollections(MoviesRepository moviesRepository) =>
      GetMovieCollections(moviesRepository);
}

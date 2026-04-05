import 'package:core/core.dart';

import 'package:movies_domain/models/movie_collection_listing.dart';
import 'package:movies_domain/repositories/movies_repository.dart';

class GetMovieCollections extends UseCase<int, Result<MovieCollectionListing>> {
  final MoviesRepository _moviesRepository;

  GetMovieCollections(this._moviesRepository);

  @override
  Future<Result<MovieCollectionListing>> call([int? params]) async =>
      _moviesRepository.getMovieCollections(page: params ?? 1);
}

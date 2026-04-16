import 'package:core/core.dart';

import 'package:movies_domain/models/movie_list_listing.dart';
import 'package:movies_domain/repositories/movies_repository.dart';

class GetFeaturedLists
    extends UseCase<int, Result<MovieListListing>> {
  final MoviesRepository _moviesRepository;

  GetFeaturedLists(this._moviesRepository);

  @override
  Future<Result<MovieListListing>> call([int? params]) async =>
      _moviesRepository.getFeaturedLists(page: params ?? 1);
}
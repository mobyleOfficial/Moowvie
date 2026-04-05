import 'package:movies_domain/models/movie_collection.dart';

class MovieCollectionListing {
  final int totalPages;
  final int totalResults;
  final List<MovieCollection> collections;

  const MovieCollectionListing({
    required this.totalPages,
    required this.totalResults,
    required this.collections,
  });
}

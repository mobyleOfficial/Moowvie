import 'package:movies_domain/domain.dart';

import 'package:movies_data/models/remote/remote_movie_collection.dart';

class RemoteMovieCollectionListing {
  final int totalPages;
  final int totalResults;
  final List<RemoteMovieCollection> collections;

  const RemoteMovieCollectionListing({
    required this.totalPages,
    required this.totalResults,
    required this.collections,
  });

  factory RemoteMovieCollectionListing.fromJson(Map<String, dynamic> json) =>
      RemoteMovieCollectionListing(
        totalPages: json['total_pages'] as int,
        totalResults: json['total_results'] as int,
        collections: (json['results'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(RemoteMovieCollection.fromJson)
            .toList(),
      );

  MovieCollectionListing toDomain() => MovieCollectionListing(
        totalPages: totalPages,
        totalResults: totalResults,
        collections:
            collections.map((collection) => collection.toDomain()).toList(),
      );
}

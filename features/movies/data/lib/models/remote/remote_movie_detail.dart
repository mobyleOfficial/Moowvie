import 'package:movies_data/models/remote/remote_movie.dart';
import 'package:movies_data/models/remote/remote_movie_review.dart';
import 'package:movies_domain/domain.dart';

class RemoteMovieDetail {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final String releaseDate;
  final String tagline;
  final int? runtime;
  final List<String> genres;
  final String? director;
  final List<String>? cast;
  final List<RemoteWatchProvider>? watchProviders;
  final List<RemoteMovie>? similarMovies;
  final List<RemoteMovieReview>? popularReviews;
  final int? reviewCount;
  final int? listCount;
  final int? likeCount;

  const RemoteMovieDetail({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.tagline,
    required this.runtime,
    required this.genres,
    this.director,
    this.cast,
    this.watchProviders,
    this.similarMovies,
    this.popularReviews,
    this.reviewCount,
    this.listCount,
    this.likeCount,
  });

  factory RemoteMovieDetail.fromJson(Map<String, dynamic> json) =>
      RemoteMovieDetail(
        id: json['id'] as int,
        title: json['title'] as String,
        overview: json['overview'] as String,
        posterPath: json['poster_path'] as String? ?? '',
        backdropPath: json['backdrop_path'] as String? ?? '',
        voteAverage: (json['vote_average'] as num).toDouble(),
        releaseDate: json['release_date'] as String? ?? '',
        tagline: json['tagline'] as String? ?? '',
        runtime: json['runtime'] as int?,
        genres: (json['genres'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map((genre) => genre['name'] as String)
            .toList(),
      );

  Movie toDomain() => Movie(
        id: id,
        title: title,
        posterPath: posterPath,
        info: MovieInfo(
          overview: overview,
          backdropPath: backdropPath,
          voteAverage: voteAverage,
          releaseDate: releaseDate,
          tagline: tagline,
          runtime: runtime ?? 0,
          genres: genres,
          director: director ?? '',
          cast: cast ?? const [],
          watchProviders:
              watchProviders?.map((provider) => provider.toDomain()).toList() ?? const [],
          similarMovies:
              similarMovies?.map((movie) => movie.toDomain()).toList() ?? const [],
          popularReviews:
              popularReviews?.map((review) => review.toDomain()).toList() ?? const [],
          reviewCount: reviewCount ?? 0,
          listCount: listCount ?? 0,
          likeCount: likeCount ?? 0,
        ),
      );
}

class RemoteWatchProvider {
  final String name;
  final String logoPath;

  const RemoteWatchProvider({required this.name, required this.logoPath});

  WatchProvider toDomain() => WatchProvider(name: name, logoPath: logoPath);
}

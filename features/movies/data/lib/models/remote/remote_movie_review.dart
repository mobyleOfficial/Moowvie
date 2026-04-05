import 'package:movies_domain/domain.dart';

class RemoteMovieReview {
  final int id;
  final String title;
  final String date;
  final double rating;

  const RemoteMovieReview({
    required this.id,
    required this.title,
    required this.date,
    required this.rating,
  });

  factory RemoteMovieReview.fromJson(Map<String, dynamic> json) =>
      RemoteMovieReview(
        id: json['movie_id'] as int,
        title: json['movie_title'] as String,
        date: json['review_date'] as String,
        rating: (json['rating'] as num).toDouble(),
      );

  MovieReview toDomain() => MovieReview(
        id: id,
        title: title,
        date: date,
        rating: rating,
      );
}

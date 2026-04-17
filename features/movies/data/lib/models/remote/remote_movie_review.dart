import 'package:movies_domain/domain.dart';

class RemoteMovieReview {
  final int id;
  final String title;
  final String date;
  final double rating;
  final String? author;
  final String? content;

  const RemoteMovieReview({
    required this.id,
    required this.title,
    required this.date,
    required this.rating,
    this.author,
    this.content,
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
        author: author,
        content: content,
      );
}

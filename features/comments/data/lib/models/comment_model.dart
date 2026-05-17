import 'package:comments_domain/models/comment.dart';

class CommentModel {
  final String id;
  final String authorName;
  final String authorAvatar;
  final String content;
  final DateTime createdAt;
  final double? rating;

  const CommentModel({
    required this.id,
    required this.authorName,
    required this.authorAvatar,
    required this.content,
    required this.createdAt,
    this.rating,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json['id'] as String,
        authorName: json['authorName'] as String,
        authorAvatar: json['authorAvatar'] as String,
        content: json['content'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
        rating: json['rating'] as double?,
      );

  Comment toDomain() => Comment(
        id: id,
        authorName: authorName,
        authorAvatar: authorAvatar,
        content: content,
        createdAt: createdAt,
        rating: rating,
      );
}

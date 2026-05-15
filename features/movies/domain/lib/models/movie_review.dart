class MovieReview {
  final String id;
  final int movieId;
  final String title;
  final String date;
  final double rating;
  final String? author;
  final String? authorId;
  final String? content;
  final int likeCount;
  final bool likedByCurrentUser;
  final int commentCount;

  const MovieReview({
    required this.id,
    required this.movieId,
    required this.title,
    required this.date,
    required this.rating,
    this.author,
    this.authorId,
    this.content,
    this.likeCount = 0,
    this.likedByCurrentUser = false,
    this.commentCount = 0,
  });

  MovieReview copyWith({
    String? id,
    int? movieId,
    String? title,
    String? date,
    double? rating,
    String? author,
    String? authorId,
    String? content,
    int? likeCount,
    bool? likedByCurrentUser,
    int? commentCount,
  }) =>
      MovieReview(
        id: id ?? this.id,
        movieId: movieId ?? this.movieId,
        title: title ?? this.title,
        date: date ?? this.date,
        rating: rating ?? this.rating,
        author: author ?? this.author,
        authorId: authorId ?? this.authorId,
        content: content ?? this.content,
        likeCount: likeCount ?? this.likeCount,
        likedByCurrentUser: likedByCurrentUser ?? this.likedByCurrentUser,
        commentCount: commentCount ?? this.commentCount,
      );
}

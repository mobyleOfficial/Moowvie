class MovieReview {
  final int id;
  final String title;
  final String date;
  final double rating;
  final String? author;
  final String? content;

  const MovieReview({
    required this.id,
    required this.title,
    required this.date,
    required this.rating,
    this.author,
    this.content,
  });
}

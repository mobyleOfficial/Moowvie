class MovieListInfo {
  final int movieCount;
  final List<String> posterPaths;
  final int totalMovies;
  final int totalPages;
  final int commentsCount;
  final int likesCount;
  final bool isLiked;
  final List<String> tags;

  const MovieListInfo({
    required this.movieCount,
    required this.posterPaths,
    this.totalMovies = 0,
    this.totalPages = 1,
    this.commentsCount = 0,
    this.likesCount = 0,
    this.isLiked = false,
    this.tags = const [],
  });
}

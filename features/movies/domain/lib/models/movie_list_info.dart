class MovieListInfo {
  final int movieCount;
  final List<String> posterPaths;
  final int? totalMovies;
  final int? totalPages;
  final int? commentsCount;
  final int? likesCount;
  final bool? isLiked;
  final List<String>? tags;

  const MovieListInfo({
    required this.movieCount,
    required this.posterPaths,
    this.totalMovies,
    this.totalPages,
    this.commentsCount,
    this.likesCount,
    this.isLiked,
    this.tags,
  });
}

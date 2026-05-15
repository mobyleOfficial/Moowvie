import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:comments_domain/models/comment_response.dart';
import 'package:comments_domain/repositories/comments_repository.dart';
import 'package:comments_data/datasources/comments_remote_data_source.dart';

@LazySingleton(as: CommentsRepository)
class CommentsRepositoryImpl implements CommentsRepository {
  final CommentsRemoteDataSource _remoteDataSource;

  CommentsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<CommentResponse>> getComments({
    required String contentId,
    required int page,
    int pageSize = 10,
  }) async {
    final result = await _remoteDataSource.getComments(
      contentId: contentId,
      page: page,
      pageSize: pageSize,
    );

    return switch (result) {
      Success(:final data) => Success(
          CommentResponse(
            comments: data.comments.map((model) => model.toDomain()).toList(),
            totalCount: data.totalCount,
            hasMore: data.hasMore,
          ),
        ),
      Failure(:final error) => Failure(error),
    };
  }
}

import 'package:core/core.dart';
import 'package:comments_domain/models/comment_listing.dart';
import 'package:comments_domain/repositories/comments_repository.dart';

class GetCommentsParams {
  final String contentId;
  final int page;
  final int pageSize;

  const GetCommentsParams({
    required this.contentId,
    this.page = 0,
    this.pageSize = 10,
  });
}

class GetCommentsUseCase
    extends UseCase<GetCommentsParams, Result<CommentListing>> {
  final CommentsRepository _repository;

  GetCommentsUseCase(this._repository);

  @override
  Future<Result<CommentListing>> call([GetCommentsParams? params]) async =>
      _repository.getComments(
        contentId: params?.contentId ?? '',
        page: params?.page ?? 0,
        pageSize: params?.pageSize ?? 10,
      );
}

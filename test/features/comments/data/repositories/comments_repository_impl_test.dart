import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';
import 'package:comments/comments.dart';

class MockCommentsRemoteDataSource implements CommentsRemoteDataSource {
  CommentsRemoteResponse? mockResponse;
  AppError? mockError;

  @override
  Future<Result<CommentsRemoteResponse>> getComments({
    required String contentId,
    required int page,
    required int pageSize,
  }) async {
    if (mockError != null) {
      return Failure(mockError!);
    }
    if (mockResponse != null) {
      return Success(mockResponse!);
    }
    return const Failure(AppError.unknown);
  }
}

void main() {
  group('CommentsRepositoryImpl', () {
    late CommentsRepositoryImpl repository;
    late MockCommentsRemoteDataSource mockRemoteDataSource;

    setUp(() {
      mockRemoteDataSource = MockCommentsRemoteDataSource();
      repository = CommentsRepositoryImpl(mockRemoteDataSource);
    });

    test('should return CommentListing with domain models when successful',
        () async {
      const contentId = 'review-001';
      const page = 0;
      const pageSize = 10;

      final mockCommentModels = [
        CommentModel(
          id: 'comment-1',
          authorName: 'Alice Smith',
          authorAvatar: 'https://example.com/alice.jpg',
          content: 'Excellent review!',
          createdAt: DateTime(2026, 5, 15),
          rating: 5.0,
        ),
      ];

      final remoteResponse = CommentsRemoteResponse(
        comments: mockCommentModels,
        totalCount: 1,
        hasMore: false,
      );

      mockRemoteDataSource.mockResponse = remoteResponse;

      final result = await repository.getComments(
        contentId: contentId,
        page: page,
        pageSize: pageSize,
      );

      expect(result, isA<Success<CommentListing>>());
      final successResult = result as Success<CommentListing>;
      expect(successResult.data.comments.length, equals(1));
      expect(successResult.data.comments[0].authorName, equals('Alice Smith'));
      expect(successResult.data.totalCount, equals(1));
      expect(successResult.data.hasMore, equals(false));
    });

    test('should propagate failure from data source', () async {
      const contentId = 'review-001';

      mockRemoteDataSource.mockError = AppError.network;

      final result = await repository.getComments(
        contentId: contentId,
        page: 0,
        pageSize: 10,
      );

      expect(result, isA<Failure<CommentListing>>());
      final failureResult = result as Failure<CommentListing>;
      expect(failureResult.error, equals(AppError.network));
    });

    test('should convert CommentModel to Comment domain model', () async {
      const contentId = 'list-001';

      final mockCommentModels = [
        CommentModel(
          id: 'comment-2',
          authorName: 'Bob Jones',
          authorAvatar: 'https://example.com/bob.jpg',
          content: 'Great list!',
          createdAt: DateTime(2026, 5, 14),
          rating: 4.0,
        ),
      ];

      final remoteResponse = CommentsRemoteResponse(
        comments: mockCommentModels,
        totalCount: 1,
        hasMore: false,
      );

      mockRemoteDataSource.mockResponse = remoteResponse;

      final result = await repository.getComments(
        contentId: contentId,
        page: 0,
        pageSize: 10,
      );

      expect(result, isA<Success<CommentListing>>());
      final successResult = result as Success<CommentListing>;
      final comment = successResult.data.comments[0];
      expect(comment, isA<Comment>());
      expect(comment.id, equals('comment-2'));
      expect(comment.authorName, equals('Bob Jones'));
      expect(comment.rating, equals(4.0));
    });

    test('should handle pagination correctly with hasMore flag', () async {
      const contentId = 'review-001';

      final mockCommentModels = List.generate(
        10,
        (index) => CommentModel(
          id: 'comment-$index',
          authorName: 'User $index',
          authorAvatar: 'https://example.com/user$index.jpg',
          content: 'Comment content $index',
          createdAt: DateTime(2026, 5, 15 - index),
        ),
      );

      final remoteResponse = CommentsRemoteResponse(
        comments: mockCommentModels,
        totalCount: 25,
        hasMore: true,
      );

      mockRemoteDataSource.mockResponse = remoteResponse;

      final result = await repository.getComments(
        contentId: contentId,
        page: 0,
        pageSize: 10,
      );

      expect(result, isA<Success<CommentListing>>());
      final successResult = result as Success<CommentListing>;
      expect(successResult.data.comments.length, equals(10));
      expect(successResult.data.totalCount, equals(25));
      expect(successResult.data.hasMore, equals(true));
    });
  });
}

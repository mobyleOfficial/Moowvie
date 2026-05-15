import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_domain/domain.dart';

import '../../../../helpers/fake_movies_repository.dart';

void main() {
  group('GetReviewComments', () {
    test('forwards reviewId and page to repository', () async {
      final fakeRepository = FakeMoviesRepository()
        ..reviewCommentsResult = const Success(
          MovieReviewCommentListing(
            page: 1,
            totalPages: 1,
            totalResults: 0,
            comments: [],
          ),
        );
      final useCase = GetReviewComments(fakeRepository);

      final result = await useCase(
        const GetReviewCommentsParams(reviewId: 'r-1-0', page: 2),
      );

      expect(fakeRepository.lastGetReviewCommentsId, 'r-1-0');
      expect(fakeRepository.lastGetReviewCommentsPage, 2);
      expect(result, isA<Success<MovieReviewCommentListing>>());
    });
  });
}

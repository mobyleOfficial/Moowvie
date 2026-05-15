import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_domain/domain.dart';

import '../../../../helpers/fake_movies_repository.dart';

void main() {
  group('LikeReview', () {
    test('delegates to repository.likeReview and returns its Result',
        () async {
      final fakeRepository = FakeMoviesRepository()
        ..likeReviewResult = const Success(null);
      final useCase = LikeReview(fakeRepository);

      final result = await useCase('r-1-0');

      expect(fakeRepository.lastLikeReviewId, 'r-1-0');
      expect(result, isA<Success<void>>());
    });

    test('propagates failure from repository', () async {
      final fakeRepository = FakeMoviesRepository()
        ..likeReviewResult = const Failure(AppError.server);
      final useCase = LikeReview(fakeRepository);

      final result = await useCase('r-1-0');

      expect(result, isA<Failure<void>>());
    });
  });
}

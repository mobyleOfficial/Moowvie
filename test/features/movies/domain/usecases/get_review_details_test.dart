import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_domain/domain.dart';

import '../../../../helpers/fake_movies_repository.dart';

void main() {
  group('GetReviewDetails', () {
    test('forwards reviewId to repository and returns Success', () async {
      final fakeRepository = FakeMoviesRepository()
        ..reviewDetailsResult = const Success(
          MovieReview(
            id: 'r-1-0',
            movieId: 1,
            title: 'Test Movie',
            date: 'Jan 1, 2024',
            rating: 4.0,
          ),
        );
      final useCase = GetReviewDetails(fakeRepository);

      final result = await useCase('r-1-0');

      expect(fakeRepository.lastGetReviewDetailsId, 'r-1-0');
      expect(result, isA<Success<MovieReview>>());
      final success = result as Success<MovieReview>;
      expect(success.data.id, 'r-1-0');
    });

    test('propagates Failure from repository', () async {
      final fakeRepository = FakeMoviesRepository()
        ..reviewDetailsResult = const Failure(AppError.notFound);
      final useCase = GetReviewDetails(fakeRepository);

      final result = await useCase('missing-id');

      expect(result, isA<Failure<MovieReview>>());
    });
  });
}

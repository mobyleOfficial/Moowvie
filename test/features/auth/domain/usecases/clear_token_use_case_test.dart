import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';
import 'package:auth_domain/domain.dart';

class MockAuthRepository implements AuthRepository {
  Result<void>? clearTokenResult;
  bool clearTokenCalled = false;

  @override
  Future<Result<void>> clearToken() async {
    clearTokenCalled = true;
    return clearTokenResult ?? const Failure(AppError.unknown);
  }

  @override
  Future<Result<AuthStatus>> checkAuthStatus() async =>
      const Failure(AppError.unknown);

  @override
  Future<Result<OAuthResult>> initiateOAuth(OAuthProvider provider) async =>
      const Failure(AppError.unknown);

  @override
  Future<Result<AuthToken>> completeOAuth(OAuthResult oauthResult) async =>
      const Failure(AppError.unknown);

  @override
  Future<Result<void>> saveToken(AuthToken token) async =>
      const Failure(AppError.unknown);
}

void main() {
  late ClearTokenUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = ClearTokenUseCase(mockRepository);
  });

  test('clears token successfully', () async {
    mockRepository.clearTokenResult = const Success(null);

    final result = await useCase();

    expect(result, isA<Success<void>>());
    expect(mockRepository.clearTokenCalled, true);
  });

  test('returns failure on error', () async {
    mockRepository.clearTokenResult = const Failure(AppError.unknown);

    final result = await useCase();

    expect(result, isA<Failure<void>>());
  });
}

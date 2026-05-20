import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';
import 'package:auth_domain/domain.dart';

class MockAuthRepository implements AuthRepository {
  Result<AuthStatus>? checkAuthStatusResult;
  Result<OAuthResult>? initiateOAuthResult;
  Result<AuthToken>? completeOAuthResult;
  Result<void>? saveTokenResult;
  Result<void>? clearTokenResult;

  @override
  Future<Result<AuthStatus>> checkAuthStatus() async =>
      checkAuthStatusResult ?? const Failure(AppError.unknown);

  @override
  Future<Result<OAuthResult>> initiateOAuth(OAuthProvider provider) async =>
      initiateOAuthResult ?? const Failure(AppError.unknown);

  @override
  Future<Result<AuthToken>> completeOAuth(OAuthResult oauthResult) async =>
      completeOAuthResult ?? const Failure(AppError.unknown);

  @override
  Future<Result<void>> saveToken(AuthToken token) async =>
      saveTokenResult ?? const Failure(AppError.unknown);

  @override
  Future<Result<void>> clearToken() async =>
      clearTokenResult ?? const Failure(AppError.unknown);
}

void main() {
  late CheckAuthStatusUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = CheckAuthStatusUseCase(mockRepository);
  });

  test('returns authenticated when token exists', () async {
    mockRepository.checkAuthStatusResult =
        const Success(AuthStatus.authenticated);

    final result = await useCase();

    expect(result, isA<Success<AuthStatus>>());
    expect((result as Success<AuthStatus>).data, AuthStatus.authenticated);
  });

  test('returns unauthenticated when no token exists', () async {
    mockRepository.checkAuthStatusResult =
        const Success(AuthStatus.unauthenticated);

    final result = await useCase();

    expect(result, isA<Success<AuthStatus>>());
    expect((result as Success<AuthStatus>).data, AuthStatus.unauthenticated);
  });

  test('returns failure on error', () async {
    mockRepository.checkAuthStatusResult = const Failure(AppError.unknown);

    final result = await useCase();

    expect(result, isA<Failure<AuthStatus>>());
  });
}

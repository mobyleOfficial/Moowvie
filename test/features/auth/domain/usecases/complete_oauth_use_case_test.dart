import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';
import 'package:auth_domain/domain.dart';

class MockAuthRepository implements AuthRepository {
  Result<AuthToken>? completeOAuthResult;
  OAuthResult? lastOAuthResult;

  @override
  Future<Result<AuthToken>> completeOAuth(OAuthResult oauthResult) async {
    lastOAuthResult = oauthResult;
    return completeOAuthResult ?? const Failure(AppError.unknown);
  }

  @override
  Future<Result<AuthStatus>> checkAuthStatus() async =>
      const Failure(AppError.unknown);

  @override
  Future<Result<OAuthResult>> initiateOAuth(OAuthProvider provider) async =>
      const Failure(AppError.unknown);

  @override
  Future<Result<void>> saveToken(AuthToken token) async =>
      const Failure(AppError.unknown);

  @override
  Future<Result<void>> clearToken() async =>
      const Failure(AppError.unknown);
}

void main() {
  late CompleteOAuthUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = CompleteOAuthUseCase(mockRepository);
  });

  test('returns AuthToken on success', () async {
    final expectedToken = AuthToken(
      accessToken: 'mock-jwt-token',
      expiresAt: DateTime(2026, 6, 19),
    );
    mockRepository.completeOAuthResult = Success(expectedToken);

    final oauthResult = OAuthResult(
      provider: OAuthProvider.google,
      providerToken: 'mock-google-token',
    );

    final result = await useCase(oauthResult);

    expect(result, isA<Success<AuthToken>>());
    expect(
      (result as Success<AuthToken>).data.accessToken,
      'mock-jwt-token',
    );
    expect(mockRepository.lastOAuthResult?.providerToken, 'mock-google-token');
  });

  test('returns failure when params are null', () async {
    final result = await useCase();

    expect(result, isA<Failure<AuthToken>>());
    expect((result as Failure<AuthToken>).error, AppError.unknown);
  });

  test('returns failure on backend error', () async {
    mockRepository.completeOAuthResult = const Failure(AppError.server);

    final oauthResult = OAuthResult(
      provider: OAuthProvider.facebook,
      providerToken: 'mock-facebook-token',
    );

    final result = await useCase(oauthResult);

    expect(result, isA<Failure<AuthToken>>());
    expect((result as Failure<AuthToken>).error, AppError.server);
  });
}

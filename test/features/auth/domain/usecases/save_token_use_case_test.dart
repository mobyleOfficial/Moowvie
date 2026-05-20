import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';
import 'package:auth_domain/domain.dart';

class MockAuthRepository implements AuthRepository {
  Result<void>? saveTokenResult;
  AuthToken? lastSavedToken;

  @override
  Future<Result<void>> saveToken(AuthToken token) async {
    lastSavedToken = token;
    return saveTokenResult ?? const Failure(AppError.unknown);
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
  Future<Result<void>> clearToken() async =>
      const Failure(AppError.unknown);
}

void main() {
  late SaveTokenUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = SaveTokenUseCase(mockRepository);
  });

  test('saves token successfully', () async {
    mockRepository.saveTokenResult = const Success(null);

    final token = AuthToken(
      accessToken: 'test-jwt',
      expiresAt: DateTime(2026, 6, 19),
    );

    final result = await useCase(token);

    expect(result, isA<Success<void>>());
    expect(mockRepository.lastSavedToken?.accessToken, 'test-jwt');
  });

  test('returns failure when params are null', () async {
    final result = await useCase();

    expect(result, isA<Failure<void>>());
  });

  test('returns failure on storage error', () async {
    mockRepository.saveTokenResult = const Failure(AppError.unknown);

    final token = AuthToken(
      accessToken: 'test-jwt',
      expiresAt: DateTime(2026, 6, 19),
    );

    final result = await useCase(token);

    expect(result, isA<Failure<void>>());
  });
}

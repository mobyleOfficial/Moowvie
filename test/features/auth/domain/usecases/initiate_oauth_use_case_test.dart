import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';
import 'package:auth_domain/domain.dart';

class MockAuthRepository implements AuthRepository {
  Result<OAuthResult>? initiateOAuthResult;
  OAuthProvider? lastProvider;

  @override
  Future<Result<OAuthResult>> initiateOAuth(OAuthProvider provider) async {
    lastProvider = provider;
    return initiateOAuthResult ?? const Failure(AppError.unknown);
  }

  @override
  Future<Result<AuthStatus>> checkAuthStatus() async =>
      const Failure(AppError.unknown);

  @override
  Future<Result<AuthToken>> completeOAuth(OAuthResult oauthResult) async =>
      const Failure(AppError.unknown);

  @override
  Future<Result<void>> saveToken(AuthToken token) async =>
      const Failure(AppError.unknown);

  @override
  Future<Result<void>> clearToken() async =>
      const Failure(AppError.unknown);
}

void main() {
  late InitiateOAuthUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = InitiateOAuthUseCase(mockRepository);
  });

  test('returns OAuthResult on success with google provider', () async {
    final expectedResult = OAuthResult(
      provider: OAuthProvider.google,
      providerToken: 'mock-google-token',
    );
    mockRepository.initiateOAuthResult = Success(expectedResult);

    final result = await useCase(OAuthProvider.google);

    expect(result, isA<Success<OAuthResult>>());
    expect(
      (result as Success<OAuthResult>).data.provider,
      OAuthProvider.google,
    );
    expect(mockRepository.lastProvider, OAuthProvider.google);
  });

  test('returns OAuthResult on success with facebook provider', () async {
    final expectedResult = OAuthResult(
      provider: OAuthProvider.facebook,
      providerToken: 'mock-facebook-token',
    );
    mockRepository.initiateOAuthResult = Success(expectedResult);

    final result = await useCase(OAuthProvider.facebook);

    expect(result, isA<Success<OAuthResult>>());
    expect(
      (result as Success<OAuthResult>).data.provider,
      OAuthProvider.facebook,
    );
    expect(mockRepository.lastProvider, OAuthProvider.facebook);
  });

  test('returns failure on error', () async {
    mockRepository.initiateOAuthResult = const Failure(AppError.network);

    final result = await useCase(OAuthProvider.google);

    expect(result, isA<Failure<OAuthResult>>());
    expect((result as Failure<OAuthResult>).error, AppError.network);
  });

  test('defaults to google when no provider given', () async {
    final expectedResult = OAuthResult(
      provider: OAuthProvider.google,
      providerToken: 'mock-google-token',
    );
    mockRepository.initiateOAuthResult = Success(expectedResult);

    await useCase();

    expect(mockRepository.lastProvider, OAuthProvider.google);
  });
}

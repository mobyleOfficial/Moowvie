import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';
import 'package:auth_domain/domain.dart';
import 'package:auth/auth.dart';

class MockOAuthRemoteDataSource implements OAuthRemoteDataSource {
  Result<OAuthResultModel>? initiateOAuthResult;
  Result<AuthTokenModel>? completeOAuthResult;

  @override
  Future<Result<OAuthResultModel>> initiateOAuth(String provider) async =>
      initiateOAuthResult ?? const Failure(AppError.unknown);

  @override
  Future<Result<AuthTokenModel>> completeOAuth(
    OAuthResultModel oauthResult,
  ) async =>
      completeOAuthResult ?? const Failure(AppError.unknown);
}

class MockAuthLocalDataSource implements AuthLocalDataSource {
  Result<AuthTokenModel?>? getTokenResult;
  Result<void>? saveTokenResult;
  Result<void>? clearTokenResult;

  @override
  Future<Result<AuthTokenModel?>> getToken() async =>
      getTokenResult ?? const Failure(AppError.unknown);

  @override
  Future<Result<void>> saveToken(AuthTokenModel token) async =>
      saveTokenResult ?? const Failure(AppError.unknown);

  @override
  Future<Result<void>> clearToken() async =>
      clearTokenResult ?? const Failure(AppError.unknown);
}

void main() {
  late AuthRepositoryImpl repository;
  late MockOAuthRemoteDataSource mockRemote;
  late MockAuthLocalDataSource mockLocal;

  setUp(() {
    mockRemote = MockOAuthRemoteDataSource();
    mockLocal = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(mockRemote, mockLocal);
  });

  group('initiateOAuth', () {
    test('maps remote result to domain OAuthResult', () async {
      mockRemote.initiateOAuthResult = const Success(
        OAuthResultModel(
          provider: 'google',
          providerToken: 'mock-token',
        ),
      );

      final result = await repository.initiateOAuth(OAuthProvider.google);

      expect(result, isA<Success<OAuthResult>>());
      final data = (result as Success<OAuthResult>).data;
      expect(data.provider, OAuthProvider.google);
      expect(data.providerToken, 'mock-token');
    });

    test('propagates failure from remote', () async {
      mockRemote.initiateOAuthResult = const Failure(AppError.network);

      final result = await repository.initiateOAuth(OAuthProvider.google);

      expect(result, isA<Failure<OAuthResult>>());
      expect((result as Failure<OAuthResult>).error, AppError.network);
    });
  });

  group('completeOAuth', () {
    test('maps remote AuthTokenModel to domain AuthToken', () async {
      mockRemote.completeOAuthResult = Success(
        AuthTokenModel(
          accessToken: 'jwt-token',
          expiresAt: DateTime(2026, 6, 19),
        ),
      );

      final oauthResult = OAuthResult(
        provider: OAuthProvider.google,
        providerToken: 'mock-token',
      );

      final result = await repository.completeOAuth(oauthResult);

      expect(result, isA<Success<AuthToken>>());
      final data = (result as Success<AuthToken>).data;
      expect(data.accessToken, 'jwt-token');
    });
  });

  group('checkAuthStatus', () {
    test('returns authenticated when valid token exists', () async {
      mockLocal.getTokenResult = Success(
        AuthTokenModel(
          accessToken: 'valid-token',
          expiresAt: DateTime.now().add(const Duration(days: 30)),
        ),
      );

      final result = await repository.checkAuthStatus();

      expect(result, isA<Success<AuthStatus>>());
      expect(
        (result as Success<AuthStatus>).data,
        AuthStatus.authenticated,
      );
    });

    test('returns unauthenticated when no token exists', () async {
      mockLocal.getTokenResult = const Success(null);

      final result = await repository.checkAuthStatus();

      expect(result, isA<Success<AuthStatus>>());
      expect(
        (result as Success<AuthStatus>).data,
        AuthStatus.unauthenticated,
      );
    });

    test('returns unauthenticated when token is expired', () async {
      mockLocal.getTokenResult = Success(
        AuthTokenModel(
          accessToken: 'expired-token',
          expiresAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
      );

      final result = await repository.checkAuthStatus();

      expect(result, isA<Success<AuthStatus>>());
      expect(
        (result as Success<AuthStatus>).data,
        AuthStatus.unauthenticated,
      );
    });
  });

  group('saveToken', () {
    test('delegates to local data source', () async {
      mockLocal.saveTokenResult = const Success(null);

      final token = AuthToken(
        accessToken: 'jwt',
        expiresAt: DateTime(2026, 6, 19),
      );

      final result = await repository.saveToken(token);

      expect(result, isA<Success<void>>());
    });
  });

  group('clearToken', () {
    test('delegates to local data source', () async {
      mockLocal.clearTokenResult = const Success(null);

      final result = await repository.clearToken();

      expect(result, isA<Success<void>>());
    });
  });
}

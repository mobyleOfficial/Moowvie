import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';
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
  AuthTokenModel? lastSavedToken;

  @override
  Future<Result<AuthTokenModel?>> getToken() async =>
      getTokenResult ?? const Failure(AppError.unknown);

  @override
  Future<Result<void>> saveToken(AuthTokenModel token) async {
    lastSavedToken = token;
    return saveTokenResult ?? const Failure(AppError.unknown);
  }

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

  group('login', () {
    test('initiates OAuth, completes it, and saves the token', () async {
      mockRemote.initiateOAuthResult = const Success(
        OAuthResultModel(provider: 'google', providerToken: 'mock-token'),
      );
      mockRemote.completeOAuthResult = Success(
        AuthTokenModel(
          accessToken: 'jwt-token',
          expiresAt: DateTime(2026, 6, 19),
        ),
      );
      mockLocal.saveTokenResult = const Success(null);

      final result = await repository.login(OAuthProvider.google);

      expect(result, isA<Success<void>>());
      expect(mockLocal.lastSavedToken?.accessToken, 'jwt-token');
    });

    test('returns failure when OAuth initiation fails', () async {
      mockRemote.initiateOAuthResult = const Failure(AppError.network);

      final result = await repository.login(OAuthProvider.google);

      expect(result, isA<Failure<void>>());
      expect((result as Failure<void>).error, AppError.network);
    });

    test('returns failure when OAuth completion fails', () async {
      mockRemote.initiateOAuthResult = const Success(
        OAuthResultModel(provider: 'google', providerToken: 'mock-token'),
      );
      mockRemote.completeOAuthResult = const Failure(AppError.server);

      final result = await repository.login(OAuthProvider.google);

      expect(result, isA<Failure<void>>());
      expect((result as Failure<void>).error, AppError.server);
    });

    test('returns failure when token save fails', () async {
      mockRemote.initiateOAuthResult = const Success(
        OAuthResultModel(provider: 'facebook', providerToken: 'mock-token'),
      );
      mockRemote.completeOAuthResult = Success(
        AuthTokenModel(
          accessToken: 'jwt-token',
          expiresAt: DateTime(2026, 6, 19),
        ),
      );
      mockLocal.saveTokenResult = const Failure(AppError.unknown);

      final result = await repository.login(OAuthProvider.facebook);

      expect(result, isA<Failure<void>>());
    });
  });

  group('isUserAuthenticated', () {
    test('returns true when valid token exists', () async {
      mockLocal.getTokenResult = Success(
        AuthTokenModel(
          accessToken: 'valid-token',
          expiresAt: DateTime.now().add(const Duration(days: 30)),
        ),
      );

      final result = await repository.isUserAuthenticated();

      expect(result, isA<Success<bool>>());
      expect((result as Success<bool>).data, true);
    });

    test('returns false when no token exists', () async {
      mockLocal.getTokenResult = const Success(null);

      final result = await repository.isUserAuthenticated();

      expect(result, isA<Success<bool>>());
      expect((result as Success<bool>).data, false);
    });

    test('returns false when token is expired', () async {
      mockLocal.getTokenResult = Success(
        AuthTokenModel(
          accessToken: 'expired-token',
          expiresAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
      );

      final result = await repository.isUserAuthenticated();

      expect(result, isA<Success<bool>>());
      expect((result as Success<bool>).data, false);
    });
  });
}

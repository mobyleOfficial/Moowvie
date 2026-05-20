import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:auth_domain/domain.dart';
import 'package:auth_ui/auth.dart';

class MockCheckAuthStatusUseCase extends CheckAuthStatusUseCase {
  Result<AuthStatus>? mockResult;

  MockCheckAuthStatusUseCase() : super(_FakeAuthRepository());

  @override
  Future<Result<AuthStatus>> call([void params]) async =>
      mockResult ?? const Failure(AppError.unknown);
}

class MockInitiateOAuthUseCase extends InitiateOAuthUseCase {
  Result<OAuthResult>? mockResult;

  MockInitiateOAuthUseCase() : super(_FakeAuthRepository());

  @override
  Future<Result<OAuthResult>> call([OAuthProvider? params]) async =>
      mockResult ?? const Failure(AppError.unknown);
}

class MockCompleteOAuthUseCase extends CompleteOAuthUseCase {
  Result<AuthToken>? mockResult;

  MockCompleteOAuthUseCase() : super(_FakeAuthRepository());

  @override
  Future<Result<AuthToken>> call([OAuthResult? params]) async =>
      mockResult ?? const Failure(AppError.unknown);
}

class MockClearTokenUseCase extends ClearTokenUseCase {
  Result<void>? mockResult;

  MockClearTokenUseCase() : super(_FakeAuthRepository());

  @override
  Future<Result<void>> call([void params]) async =>
      mockResult ?? const Failure(AppError.unknown);
}

class _FakeAuthRepository implements AuthRepository {
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

  @override
  Future<Result<void>> clearToken() async =>
      const Failure(AppError.unknown);
}

void main() {
  late MockCheckAuthStatusUseCase mockCheckAuthStatus;
  late MockInitiateOAuthUseCase mockInitiateOAuth;
  late MockCompleteOAuthUseCase mockCompleteOAuth;
  late MockClearTokenUseCase mockClearToken;

  setUp(() {
    mockCheckAuthStatus = MockCheckAuthStatusUseCase();
    mockInitiateOAuth = MockInitiateOAuthUseCase();
    mockCompleteOAuth = MockCompleteOAuthUseCase();
    mockClearToken = MockClearTokenUseCase();
  });

  AuthCubit buildCubit() => AuthCubit(
        checkAuthStatusUseCase: mockCheckAuthStatus,
        initiateOAuthUseCase: mockInitiateOAuth,
        completeOAuthUseCase: mockCompleteOAuth,
        clearTokenUseCase: mockClearToken,
      );

  group('checkAuthStatus', () {
    blocTest<AuthCubit, LoginState>(
      'emits [LoginLoading, LoginAuthenticated] when user is authenticated',
      build: () {
        mockCheckAuthStatus.mockResult =
            const Success(AuthStatus.authenticated);
        return buildCubit();
      },
      act: (cubit) => cubit.checkAuthStatus(),
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginAuthenticated>(),
      ],
    );

    blocTest<AuthCubit, LoginState>(
      'emits [LoginLoading, LoginUnauthenticated] when user is not authenticated',
      build: () {
        mockCheckAuthStatus.mockResult =
            const Success(AuthStatus.unauthenticated);
        return buildCubit();
      },
      act: (cubit) => cubit.checkAuthStatus(),
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginUnauthenticated>(),
      ],
    );

    blocTest<AuthCubit, LoginState>(
      'emits [LoginLoading, LoginUnauthenticated] on failure',
      build: () {
        mockCheckAuthStatus.mockResult = const Failure(AppError.unknown);
        return buildCubit();
      },
      act: (cubit) => cubit.checkAuthStatus(),
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginUnauthenticated>(),
      ],
    );
  });

  group('loginWithGoogle', () {
    blocTest<AuthCubit, LoginState>(
      'emits [LoginLoading, LoginAuthenticated] on successful Google login',
      build: () {
        mockInitiateOAuth.mockResult = Success(
          OAuthResult(
            provider: OAuthProvider.google,
            providerToken: 'google-token',
          ),
        );
        mockCompleteOAuth.mockResult = Success(
          AuthToken(
            accessToken: 'jwt',
            expiresAt: DateTime(2026, 6, 19),
          ),
        );
        return buildCubit();
      },
      act: (cubit) => cubit.loginWithGoogle(),
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginAuthenticated>(),
      ],
    );

    blocTest<AuthCubit, LoginState>(
      'emits [LoginLoading, LoginError] when OAuth initiation fails',
      build: () {
        mockInitiateOAuth.mockResult = const Failure(AppError.network);
        return buildCubit();
      },
      act: (cubit) => cubit.loginWithGoogle(),
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginError>(),
      ],
    );

    blocTest<AuthCubit, LoginState>(
      'emits [LoginLoading, LoginError] when OAuth completion fails',
      build: () {
        mockInitiateOAuth.mockResult = Success(
          OAuthResult(
            provider: OAuthProvider.google,
            providerToken: 'google-token',
          ),
        );
        mockCompleteOAuth.mockResult = const Failure(AppError.server);
        return buildCubit();
      },
      act: (cubit) => cubit.loginWithGoogle(),
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginError>(),
      ],
    );
  });

  group('logout', () {
    blocTest<AuthCubit, LoginState>(
      'emits [LoginLoading, LoginUnauthenticated] on successful logout',
      build: () {
        mockClearToken.mockResult = const Success(null);
        return buildCubit();
      },
      act: (cubit) => cubit.logout(),
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginUnauthenticated>(),
      ],
    );

    blocTest<AuthCubit, LoginState>(
      'emits [LoginLoading, LoginError] when logout fails',
      build: () {
        mockClearToken.mockResult = const Failure(AppError.unknown);
        return buildCubit();
      },
      act: (cubit) => cubit.logout(),
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginError>(),
      ],
    );
  });
}

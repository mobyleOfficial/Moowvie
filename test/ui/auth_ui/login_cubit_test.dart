import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:auth_domain/domain.dart';
import 'package:auth_ui/auth.dart';

class MockLoginUseCase extends Login {
  Result<void>? mockResult;

  MockLoginUseCase() : super(_FakeAuthRepository());

  @override
  Future<Result<void>> call([OAuthProvider? params]) async =>
      mockResult ?? const Failure(AppError.unknown);
}

class MockIsUserAuthenticatedUseCase extends IsUserAuthenticated {
  Result<bool>? mockResult;

  MockIsUserAuthenticatedUseCase() : super(_FakeAuthRepository());

  @override
  Future<Result<bool>> call([void params]) async =>
      mockResult ?? const Failure(AppError.unknown);
}

class _FakeAuthRepository implements AuthRepository {
  @override
  Future<Result<void>> login(OAuthProvider provider) async =>
      const Failure(AppError.unknown);

  @override
  Future<Result<bool>> isUserAuthenticated() async =>
      const Failure(AppError.unknown);
}

void main() {
  late MockLoginUseCase mockLogin;
  late MockIsUserAuthenticatedUseCase mockIsUserAuthenticated;

  setUp(() {
    mockLogin = MockLoginUseCase();
    mockIsUserAuthenticated = MockIsUserAuthenticatedUseCase();
  });

  LoginCubit buildCubit() => LoginCubit(
        loginUseCase: mockLogin,
        isUserAuthenticatedUseCase: mockIsUserAuthenticated,
      );

  group('checkAuthStatus', () {
    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginAuthenticated] when user is authenticated',
      build: () {
        mockIsUserAuthenticated.mockResult = const Success(true);
        return buildCubit();
      },
      act: (cubit) => cubit.checkAuthStatus(),
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginAuthenticated>(),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginUnauthenticated] when not authenticated',
      build: () {
        mockIsUserAuthenticated.mockResult = const Success(false);
        return buildCubit();
      },
      act: (cubit) => cubit.checkAuthStatus(),
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginUnauthenticated>(),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginUnauthenticated] on failure',
      build: () {
        mockIsUserAuthenticated.mockResult =
            const Failure(AppError.unknown);
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
    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginAuthenticated] on success',
      build: () {
        mockLogin.mockResult = const Success(null);
        return buildCubit();
      },
      act: (cubit) => cubit.loginWithGoogle(),
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginAuthenticated>(),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginError] on failure',
      build: () {
        mockLogin.mockResult = const Failure(AppError.network);
        return buildCubit();
      },
      act: (cubit) => cubit.loginWithGoogle(),
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginError>(),
      ],
    );
  });

  group('loginWithFacebook', () {
    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginAuthenticated] on success',
      build: () {
        mockLogin.mockResult = const Success(null);
        return buildCubit();
      },
      act: (cubit) => cubit.loginWithFacebook(),
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginAuthenticated>(),
      ],
    );
  });
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:auth/auth.dart';
import 'package:auth_ui/login_state.dart';

class AuthCubit extends Cubit<LoginState> {
  final CheckAuthStatusUseCase _checkAuthStatusUseCase;
  final InitiateOAuthUseCase _initiateOAuthUseCase;
  final CompleteOAuthUseCase _completeOAuthUseCase;
  final ClearTokenUseCase _clearTokenUseCase;

  AuthCubit({
    required CheckAuthStatusUseCase checkAuthStatusUseCase,
    required InitiateOAuthUseCase initiateOAuthUseCase,
    required CompleteOAuthUseCase completeOAuthUseCase,
    required ClearTokenUseCase clearTokenUseCase,
  })  : _checkAuthStatusUseCase = checkAuthStatusUseCase,
        _initiateOAuthUseCase = initiateOAuthUseCase,
        _completeOAuthUseCase = completeOAuthUseCase,
        _clearTokenUseCase = clearTokenUseCase,
        super(const LoginLoading());

  Future<void> checkAuthStatus() async {
    emit(const LoginLoading());

    final result = await _checkAuthStatusUseCase();

    switch (result) {
      case Success(:final data):
        switch (data) {
          case AuthStatus.authenticated:
            emit(const LoginAuthenticated());
          case AuthStatus.unauthenticated:
          case AuthStatus.unknown:
            emit(const LoginUnauthenticated());
        }
      case Failure(:final error):
        emit(const LoginUnauthenticated());
    }
  }

  Future<void> loginWithGoogle() async =>
      _loginWithProvider(OAuthProvider.google);

  Future<void> loginWithFacebook() async =>
      _loginWithProvider(OAuthProvider.facebook);

  Future<void> _loginWithProvider(OAuthProvider provider) async {
    emit(const LoginLoading());

    final oauthResult = await _initiateOAuthUseCase(provider);

    switch (oauthResult) {
      case Success(:final data):
        final tokenResult = await _completeOAuthUseCase(data);

        switch (tokenResult) {
          case Success():
            emit(const LoginAuthenticated());
          case Failure(:final error):
            emit(LoginError(error.message));
        }
      case Failure(:final error):
        emit(LoginError(error.message));
    }
  }

  Future<void> logout() async {
    emit(const LoginLoading());

    final result = await _clearTokenUseCase();

    switch (result) {
      case Success():
        emit(const LoginUnauthenticated());
      case Failure(:final error):
        emit(LoginError(error.message));
    }
  }
}

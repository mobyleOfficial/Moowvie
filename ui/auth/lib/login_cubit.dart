import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:auth/auth.dart';
import 'package:auth_ui/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Login _loginUseCase;
  final IsUserAuthenticated _isUserAuthenticatedUseCase;

  LoginCubit({
    required Login loginUseCase,
    required IsUserAuthenticated isUserAuthenticatedUseCase,
  })  : _loginUseCase = loginUseCase,
        _isUserAuthenticatedUseCase = isUserAuthenticatedUseCase,
        super(const LoginUnauthenticated());

  Future<void> checkAuthStatus() async {
    emit(const LoginLoading());

    final result = await _isUserAuthenticatedUseCase();

    switch (result) {
      case Success(:final data):
        data
            ? emit(const LoginAuthenticated())
            : emit(const LoginUnauthenticated());
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

    final result = await _loginUseCase(provider);

    switch (result) {
      case Success():
        emit(const LoginAuthenticated());
      case Failure(:final error):
        emit(LoginError(error.message));
    }
  }
}

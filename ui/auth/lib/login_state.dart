sealed class LoginState {
  const LoginState();
}

final class LoginLoading extends LoginState {
  const LoginLoading();
}

final class LoginAuthenticated extends LoginState {
  const LoginAuthenticated();
}

final class LoginUnauthenticated extends LoginState {
  const LoginUnauthenticated();
}

final class LoginError extends LoginState {
  final String message;

  const LoginError(this.message);
}

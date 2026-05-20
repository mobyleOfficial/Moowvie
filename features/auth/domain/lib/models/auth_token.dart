class AuthToken {
  final String accessToken;
  final String? refreshToken;
  final DateTime expiresAt;

  const AuthToken({
    required this.accessToken,
    this.refreshToken,
    required this.expiresAt,
  });
}

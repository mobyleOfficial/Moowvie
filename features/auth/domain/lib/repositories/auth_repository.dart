import 'package:core/core.dart';
import 'package:auth_domain/models/auth_status.dart';
import 'package:auth_domain/models/auth_token.dart';
import 'package:auth_domain/models/oauth_provider.dart';
import 'package:auth_domain/models/oauth_result.dart';

abstract interface class AuthRepository {
  Future<Result<OAuthResult>> initiateOAuth(OAuthProvider provider);
  Future<Result<AuthToken>> completeOAuth(OAuthResult oauthResult);
  Future<Result<AuthStatus>> checkAuthStatus();
  Future<Result<void>> saveToken(AuthToken token);
  Future<Result<void>> clearToken();
}

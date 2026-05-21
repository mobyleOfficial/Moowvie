import 'package:core/core.dart';
import 'package:auth_data/models/auth_token_model.dart';
import 'package:auth_data/models/oauth_result_model.dart';

abstract interface class OAuthRemoteDataSource {
  Future<Result<OAuthResultModel>> initiateOAuth(String provider);
  Future<Result<AuthTokenModel>> completeOAuth(OAuthResultModel oauthResult);
}

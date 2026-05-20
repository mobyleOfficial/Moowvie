import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:auth_domain/models/auth_status.dart';
import 'package:auth_domain/models/auth_token.dart';
import 'package:auth_domain/models/oauth_provider.dart';
import 'package:auth_domain/models/oauth_result.dart';
import 'package:auth_domain/repositories/auth_repository.dart';
import 'package:auth_data/datasources/oauth_remote_data_source.dart';
import 'package:auth_data/datasources/auth_local_data_source.dart';
import 'package:auth_data/models/auth_token_model.dart';
import 'package:auth_data/models/oauth_result_model.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final OAuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Result<OAuthResult>> initiateOAuth(OAuthProvider provider) async {
    final providerString =
        provider == OAuthProvider.google ? 'google' : 'facebook';
    final result = await _remoteDataSource.initiateOAuth(providerString);

    return switch (result) {
      Success(:final data) => Success(data.toDomain()),
      Failure(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<AuthToken>> completeOAuth(OAuthResult oauthResult) async {
    final oauthModel = OAuthResultModel.fromDomain(oauthResult);
    final result = await _remoteDataSource.completeOAuth(oauthModel);

    return switch (result) {
      Success(:final data) => Success(data.toDomain()),
      Failure(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<AuthStatus>> checkAuthStatus() async {
    final result = await _localDataSource.getToken();

    return switch (result) {
      Success(:final data) => data != null &&
              data.toDomain().expiresAt.isAfter(DateTime.now())
          ? const Success(AuthStatus.authenticated)
          : const Success(AuthStatus.unauthenticated),
      Failure(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<void>> saveToken(AuthToken token) async {
    final tokenModel = AuthTokenModel.fromDomain(token);
    return _localDataSource.saveToken(tokenModel);
  }

  @override
  Future<Result<void>> clearToken() async => _localDataSource.clearToken();
}

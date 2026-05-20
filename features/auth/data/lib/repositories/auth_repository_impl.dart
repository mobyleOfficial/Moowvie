import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:auth_domain/models/oauth_provider.dart';
import 'package:auth_domain/repositories/auth_repository.dart';
import 'package:auth_data/datasources/oauth_remote_data_source.dart';
import 'package:auth_data/datasources/auth_local_data_source.dart';
import 'package:auth_data/models/oauth_result_model.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final OAuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Result<void>> login(OAuthProvider provider) async {
    final providerString =
        provider == OAuthProvider.google ? 'google' : 'facebook';

    final oauthResult = await _remoteDataSource.initiateOAuth(providerString);

    switch (oauthResult) {
      case Success(:final data):
        final tokenResult = await _remoteDataSource.completeOAuth(data);

        switch (tokenResult) {
          case Success(:final data):
            return _localDataSource.saveToken(data);
          case Failure(:final error):
            return Failure(error);
        }
      case Failure(:final error):
        return Failure(error);
    }
  }

  @override
  Future<Result<bool>> isUserAuthenticated() async {
    final result = await _localDataSource.getToken();

    return switch (result) {
      Success(:final data) => Success(
          data != null && data.expiresAt.isAfter(DateTime.now()),
        ),
      Failure(:final error) => Failure(error),
    };
  }
}

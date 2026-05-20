import 'package:core/core.dart';
import 'package:auth_domain/models/oauth_provider.dart';
import 'package:auth_domain/models/oauth_result.dart';
import 'package:auth_domain/repositories/auth_repository.dart';

class InitiateOAuthUseCase
    extends UseCase<OAuthProvider, Result<OAuthResult>> {
  final AuthRepository _repository;

  InitiateOAuthUseCase(this._repository);

  @override
  Future<Result<OAuthResult>> call([OAuthProvider? params]) async =>
      _repository.initiateOAuth(params ?? OAuthProvider.google);
}

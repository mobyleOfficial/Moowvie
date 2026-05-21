import 'package:core/core.dart';
import 'package:auth_domain/models/oauth_provider.dart';
import 'package:auth_domain/repositories/auth_repository.dart';

class Login extends UseCase<OAuthProvider, Result<void>> {
  final AuthRepository _repository;

  Login(this._repository);

  @override
  Future<Result<void>> call([OAuthProvider? params]) async =>
      _repository.login(params ?? OAuthProvider.google);
}

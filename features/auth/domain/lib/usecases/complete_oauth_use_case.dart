import 'package:core/core.dart';
import 'package:auth_domain/models/auth_token.dart';
import 'package:auth_domain/models/oauth_result.dart';
import 'package:auth_domain/repositories/auth_repository.dart';

class CompleteOAuthUseCase
    extends UseCase<OAuthResult, Result<AuthToken>> {
  final AuthRepository _repository;

  CompleteOAuthUseCase(this._repository);

  @override
  Future<Result<AuthToken>> call([OAuthResult? params]) async {
    if (params == null) {
      return const Failure(AppError.unknown);
    }
    return _repository.completeOAuth(params);
  }
}

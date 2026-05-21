import 'package:injectable/injectable.dart';
import 'package:auth/auth.dart';

@module
abstract class AuthModule {
  @lazySingleton
  SecureTokenStorage secureTokenStorage() => SecureTokenStorage();

  @lazySingleton
  OAuthRemoteDataSource oauthRemoteDataSource() =>
      OAuthRemoteDataSourceImpl();

  @lazySingleton
  AuthLocalDataSource authLocalDataSource(
    SecureTokenStorage secureStorage,
  ) =>
      AuthLocalDataSourceImpl(secureStorage);

  @lazySingleton
  AuthRepository authRepository(
    OAuthRemoteDataSource remoteDataSource,
    AuthLocalDataSource localDataSource,
  ) =>
      AuthRepositoryImpl(remoteDataSource, localDataSource);

  @injectable
  Login loginUseCase(
    AuthRepository repository,
  ) =>
      Login(repository);

  @injectable
  IsUserAuthenticated isUserAuthenticatedUseCase(
    AuthRepository repository,
  ) =>
      IsUserAuthenticated(repository);
}

import 'package:injectable/injectable.dart';
import 'package:comments/comments.dart';

@module
abstract class CommentsModule {
  @injectable
  CommentsRemoteDataSource commentsRemoteDataSource() =>
      CommentsRemoteDataSourceImpl();

  @lazySingleton
  CommentsRepository commentsRepository(
    CommentsRemoteDataSource remoteDataSource,
  ) =>
      CommentsRepositoryImpl(remoteDataSource);

  @injectable
  GetCommentsUseCase getCommentsUseCase(CommentsRepository repository) =>
      GetCommentsUseCase(repository);
}

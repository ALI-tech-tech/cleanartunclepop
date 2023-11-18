import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:clean_architecture_posts_app/features/post/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

class DeletePostUsecase {
  final PostRepository repository;

  DeletePostUsecase(this.repository);
   Future<Either<Failure,Unit>> call(int postId) async{
    return await repository.deletePost(postId);
   }
}
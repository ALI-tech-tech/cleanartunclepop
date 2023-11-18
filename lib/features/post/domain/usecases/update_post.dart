import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:clean_architecture_posts_app/features/post/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/features/post/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePostUsecase {
  final PostRepository repository;

  UpdatePostUsecase(this.repository);
   Future<Either<Failure,Unit>> call(Post post) async{
    return await repository.updatePost(post);
   }
}
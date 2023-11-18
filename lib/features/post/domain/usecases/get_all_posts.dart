import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:clean_architecture_posts_app/features/post/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/features/post/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllPostsUsecase {
  final PostRepository repository;

  GetAllPostsUsecase(this.repository);
  Future<Either<Failure,List<Post>>> call() async {
    return await repository.getAllPosts();
  }

}
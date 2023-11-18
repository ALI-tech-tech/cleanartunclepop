import 'package:clean_architecture_posts_app/features/post/domain/entities/post.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

/// PostRepository is an abstract class defining the contract for operations
/// related to data within the domain layer.
/// Concrete implementations of this repository interface will be provided
/// in the data layer to interact with specific data sources (e.g., API, database).
abstract class PostRepository {
  Future<Either<Failure,List<Post>>> getAllPosts(); 
  Future<Either<Failure,Unit>> deletePost(int id);
  Future<Either<Failure,Unit>> updatePost(Post post);
  Future<Either<Failure,Unit>> addPost(Post post);


}
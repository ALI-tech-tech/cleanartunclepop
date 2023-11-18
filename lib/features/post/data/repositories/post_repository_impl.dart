// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_architecture_posts_app/features/post/data/models/post_model.dart';
import 'package:dartz/dartz.dart';

import 'package:clean_architecture_posts_app/core/error/exception.dart';
import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:clean_architecture_posts_app/core/network/netwrk_info.dart';
import 'package:clean_architecture_posts_app/features/post/data/data_sources/Remote_data_source.dart';
import 'package:clean_architecture_posts_app/features/post/data/data_sources/post_data_source.dart';
import 'package:clean_architecture_posts_app/features/post/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/features/post/domain/repositories/post_repository.dart';

/// PostRepositoryImpl is the concrete implementation of the PostRepository
/// interface.
/// This class implements the methods defined in PostRepository to interact
/// with data. It acts as a bridge between the domain layer
/// (use cases) and the data layer (data sources).


typedef Future<Unit> DeleteOrUpdateOrAddPost();

class PostRepositoryImpl implements PostRepository {
  final PostDataSource postDataSource;
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  PostRepositoryImpl({
    required this.postDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteposts = await remoteDataSource.getAllPosts();
        postDataSource.cachePosts(remoteposts);
        return Right(remoteposts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localposts = await postDataSource.getCachedPost();
        return Right(localposts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel =
        PostModel(title: post.title, body: post.body);
    return await _getmessge(() {
      return remoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _getmessge(() {
      return remoteDataSource.deletePost(postId);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getmessge(() {
      return remoteDataSource.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _getmessge(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost;
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}

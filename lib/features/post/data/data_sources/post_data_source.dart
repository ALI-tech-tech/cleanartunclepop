import 'dart:convert';

import 'package:clean_architecture_posts_app/core/error/exception.dart';
import 'package:clean_architecture_posts_app/features/post/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// PostDataSource is an abstract class defining the contract for fetching
/// data from various sources.
/// This abstract class outlines the methods that concrete data source
/// implementations should implement, such as fetching data from a remote API, local database, or any other data source.
abstract class PostDataSource {
  Future<List<PostModel>> getCachedPost();
  Future<Unit> cachePosts(List<PostModel> postModel);
}

/// PostDataSourceImpl is the concrete implementation of the PostDataSource
/// interface.
/// This class implements the methods defined in PostDataSource to fetch
/// data from a remote API or other data sources.

const CACHED_POSTS="CACHED_POSTS";
class PostDataSourceImpl implements PostDataSource {
  final SharedPreferences sharedPreferences;

  PostDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    sharedPreferences.setString(CACHED_POSTS, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPost() {
    final jsonString = sharedPreferences.getString(CACHED_POSTS);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    }else{
      throw EmptyCacheException();
    }
  }
}

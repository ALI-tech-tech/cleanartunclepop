import 'package:clean_architecture_posts_app/core/network/netwrk_info.dart';
import 'package:clean_architecture_posts_app/features/post/data/data_sources/Remote_data_source.dart';
import 'package:clean_architecture_posts_app/features/post/data/data_sources/post_data_source.dart';
import 'package:clean_architecture_posts_app/features/post/data/repositories/post_repository_impl.dart';
import 'package:clean_architecture_posts_app/features/post/domain/repositories/post_repository.dart';
import 'package:clean_architecture_posts_app/features/post/domain/usecases/add_post.dart';
import 'package:clean_architecture_posts_app/features/post/domain/usecases/delete_post.dart';
import 'package:clean_architecture_posts_app/features/post/domain/usecases/get_all_posts.dart';
import 'package:clean_architecture_posts_app/features/post/domain/usecases/update_post.dart';
import 'package:clean_architecture_posts_app/features/post/presentation/blocs/add_delete_upadate_post/add_delete_upadate_post_bloc.dart';
import 'package:clean_architecture_posts_app/features/post/presentation/blocs/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Feature = posts

  //Bloc
  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(() => AddDeleteUpadatePostBloc(
      addPost: sl(), updatePost: sl(), deletePost: sl()));

  //Usecases
  sl.registerLazySingleton(() => GetAllPostsUsecase(sl()));
  sl.registerLazySingleton(() => AddPostUsecase(sl()));
  sl.registerLazySingleton(() => DeletePostUsecase(sl()));
  sl.registerLazySingleton(() => UpdatePostUsecase(sl()));


  //Repoistory
  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(
    postDataSource: sl(), 
    remoteDataSource: sl(), 
    networkInfo: sl()));


  //Datasource

  sl.registerLazySingleton<RemoteDataSource>(() => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostDataSource>(() => PostDataSourceImpl(sharedPreferences: sl()));


  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl( sl()));

  //External

  final sharedPreferences=await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

    sl.registerLazySingleton(() => http.Client());
    sl.registerLazySingleton(() => InternetConnectionChecker());



}

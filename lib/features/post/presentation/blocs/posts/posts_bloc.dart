import 'package:bloc/bloc.dart';
import 'package:clean_architecture_posts_app/core/Strings/failures.dart';
import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:clean_architecture_posts_app/features/post/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/features/post/domain/usecases/get_all_posts.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUsecase getAllPosts;
  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPosts();
        emit(_mpFailureOrPostsToState(failureOrPosts));
      }else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPosts();
        emit(_mpFailureOrPostsToState(failureOrPosts));
      }
    });
  }


  PostsState _mpFailureOrPostsToState(Either<Failure, List<Post>> either) {
    return either.fold(
        (failuer) => ErrorPostsState(message: _mapFailureToMessage(failuer)),
        (posts) => LoadedPostsState(posts: posts));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAIURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAIURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAIURE_MESSAGE;
      default:
        return "Unexpected Error , Pleas try again later . ";
    }
  }
}

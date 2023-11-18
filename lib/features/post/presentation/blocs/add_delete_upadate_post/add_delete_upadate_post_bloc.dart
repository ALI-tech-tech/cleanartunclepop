// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:clean_architecture_posts_app/core/Strings/failures.dart';
import 'package:clean_architecture_posts_app/core/Strings/meaages.dart';
import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:clean_architecture_posts_app/features/post/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/features/post/domain/usecases/add_post.dart';
import 'package:clean_architecture_posts_app/features/post/domain/usecases/delete_post.dart';
import 'package:clean_architecture_posts_app/features/post/domain/usecases/update_post.dart';

part 'add_delete_upadate_post_event.dart';
part 'add_delete_upadate_post_state.dart';

class AddDeleteUpadatePostBloc
    extends Bloc<AddDeleteUpadatePostEvent, AddDeleteUpadatePostState> {
  final AddPostUsecase addPost;
  final DeletePostUsecase deletePost;
  final UpdatePostUsecase updatePost;

  AddDeleteUpadatePostBloc({
    required this.addPost,
    required this.deletePost,
    required this.updatePost,
  }) : super(AddDeleteUpadatePostInitial()) {
    on<AddDeleteUpadatePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final falureOrDoneMessage = await addPost(event.post);
        emit(_eitherDoneMessageOrErrorState(falureOrDoneMessage, ADD_SUCCESS_MESSAGE));

      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final falureOrDoneMessage = await updatePost(event.post);
        emit(_eitherDoneMessageOrErrorState(falureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));

      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final falureOrDoneMessage = await deletePost(event.postId);
        emit(_eitherDoneMessageOrErrorState(falureOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      }
    });
  }

  AddDeleteUpadatePostState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
        (failure) => ErrorAddDeleteUpdatePostState(
            message: _mapFailureToMessage(failure)),
        (_) =>
            MessageAddDeleteUpdatePostState(message: message));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAIURE_MESSAGE;

      case OfflineFailure:
        return OFFLINE_FAIURE_MESSAGE;
      default:
        return "Unexpected Error , Pleas try again later . ";
    }
  }
}

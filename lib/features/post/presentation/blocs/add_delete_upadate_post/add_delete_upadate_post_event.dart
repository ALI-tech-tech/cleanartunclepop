part of 'add_delete_upadate_post_bloc.dart';

sealed class AddDeleteUpadatePostEvent extends Equatable {
  const AddDeleteUpadatePostEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends AddDeleteUpadatePostEvent {
  final Post post;

  AddPostEvent({required this.post});
  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends AddDeleteUpadatePostEvent {
  final Post post;

  UpdatePostEvent({required this.post});
  @override
  List<Object> get props => [post];
}


class DeletePostEvent extends AddDeleteUpadatePostEvent {
  final int postId;

  DeletePostEvent({required this.postId});
  @override
  List<Object> get props => [postId];
}
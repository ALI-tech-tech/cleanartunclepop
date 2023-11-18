part of 'add_delete_upadate_post_bloc.dart';

sealed class AddDeleteUpadatePostState extends Equatable {
  const AddDeleteUpadatePostState();
  
  @override
  List<Object> get props => [];
}

final class AddDeleteUpadatePostInitial extends AddDeleteUpadatePostState {}


class LoadingAddDeleteUpdatePostState extends AddDeleteUpadatePostState {
  
}

class ErrorAddDeleteUpdatePostState extends AddDeleteUpadatePostState {
  final String message;

  ErrorAddDeleteUpdatePostState({required this.message});

   @override
  List<Object> get props => [message];
}

class MessageAddDeleteUpdatePostState extends AddDeleteUpadatePostState {
  final String message;

  MessageAddDeleteUpdatePostState({required this.message});
   @override
  List<Object> get props => [message];
}
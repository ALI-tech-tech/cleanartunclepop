import 'package:clean_architecture_posts_app/core/util/snakbar_message.dart';
import 'package:clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:clean_architecture_posts_app/features/post/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/features/post/presentation/blocs/add_delete_upadate_post/add_delete_upadate_post_bloc.dart';
import 'package:clean_architecture_posts_app/features/post/presentation/pages/post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/post_add_update_page/form_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;
  const PostAddUpdatePage({super.key, this.post, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: Text(isUpdatePost ? "Edit Post" : "Add Post"),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child:
            BlocConsumer<AddDeleteUpadatePostBloc, AddDeleteUpadatePostState>(
          listener: (context, state) {
            if (state is MessageAddDeleteUpdatePostState) {
             SnackBarMessage().showSuccessSnackBar(message: state.message, context: context);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostsPage(),
                  ),
                  (route) => false);
            }else if (state is ErrorAddDeleteUpdatePostState) {
              SnackBarMessage().showErrorSnackBar(message: state.message, context: context);

            }
          },
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdatePostState) {
              return LoadingWidget();
            }
            
            return FormWidget(isUpdatePost:isUpdatePost, post:isUpdatePost?post:null);
          },
        ),
      ),
    );
  }
}

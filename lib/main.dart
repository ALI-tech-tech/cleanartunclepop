import 'package:clean_architecture_posts_app/core/app_theme.dart';
import 'package:clean_architecture_posts_app/features/post/presentation/blocs/add_delete_upadate_post/add_delete_upadate_post_bloc.dart';
import 'package:clean_architecture_posts_app/features/post/presentation/blocs/posts/posts_bloc.dart';
import 'package:clean_architecture_posts_app/features/post/presentation/pages/post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp( ));
}

class MyApp extends StatelessWidget {
  
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => di.sl<PostsBloc>()..add(GetAllPostsEvent())), 
          BlocProvider(create: (context) => di.sl<AddDeleteUpadatePostBloc>(),), 
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          title: 'Posts App',
          home: PostsPage(),
        ));
  }
}

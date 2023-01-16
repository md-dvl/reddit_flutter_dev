import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit_flutter_dev/bloc/posts_bloc.dart';
import 'package:reddit_flutter_dev/data/local_storage.dart';
import 'package:reddit_flutter_dev/repositories/dio_settings.dart';
import 'package:reddit_flutter_dev/repositories/reddit_repo.dart';
import 'package:reddit_flutter_dev/screens/main_screen.dart';
import 'package:reddit_flutter_dev/services/preference_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => DioSettings(),
        ),
        RepositoryProvider(
          create: (context) => PreferenceService(),
        ),
        RepositoryProvider(
          create: (context) =>
              RedditRepo(RepositoryProvider.of<DioSettings>(context).dio),
        ),
        RepositoryProvider(
          create: (context) => LocalPostsStorage(
              RepositoryProvider.of<PreferenceService>(context)),
        ),
      ],
      child: BlocProvider(
        create: (context) => PostsBloc(
          RepositoryProvider.of<RedditRepo>(context),
          RepositoryProvider.of<LocalPostsStorage>(context),
        )..add(GetPosts()),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MainScreen(),
        ),
      ),
    );
  }
}

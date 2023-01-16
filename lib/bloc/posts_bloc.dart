import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit_flutter_dev/data/local_storage.dart';
import 'package:reddit_flutter_dev/models/post_model.dart';
import 'package:reddit_flutter_dev/repositories/reddit_repo.dart';

class PostsBloc extends Bloc<PostsEvent, PostsStates> {
  final RedditRepo repo;
  final LocalPostsStorage localRepo;
  PostsBloc(this.repo, this.localRepo) : super(InitialState()) {
    on<GetPosts>(
      ((event, emit) async {
        try {
          emit(LoadingState());
          final result = await repo.getPosts();
          final List<PostModel> models = result.results ?? [];
          localRepo.savePostsToCache(models);
          emit(SuccessState(models));
        } catch (SocketException) {
          try {
            final List<PostModel> models = localRepo.getPostsFromCache();
            emit(SuccessState(models));
          } catch (e) {
            emit(ErrorState());
          }
        }
      }),
    );
  }
}

abstract class PostsEvent {}

class GetPosts extends PostsEvent {}

abstract class PostsStates {}

class SuccessState extends PostsStates {
  final List<PostModel> models;
  SuccessState(this.models);
}

class InitialState extends PostsStates {}

class ErrorState extends PostsStates {}

class LoadingState extends PostsStates {}

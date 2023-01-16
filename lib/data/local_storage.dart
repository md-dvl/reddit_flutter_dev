import 'dart:convert';

import 'package:reddit_flutter_dev/models/post_model.dart';
import 'package:reddit_flutter_dev/services/preference_service.dart';

class LocalPostsStorage {
  final PreferenceService preferenceService;
  LocalPostsStorage(this.preferenceService);
  List<PostModel> getPostsFromCache() {
    final List<String> jsonPostsList = preferenceService.getPosts();
    if (jsonPostsList.isNotEmpty) {
      return jsonPostsList
          .map((post) => PostModel.fromJson(json.decode(post)))
          .toList();
    } else {
      throw Exception();
    }
  }

  savePostsToCache(List<PostModel> posts) {
    final List<String> jsonPostsList =
        posts.map((post) => json.encode(post.toJson())).toList();
    preferenceService.savePosts(jsonPostsList);
  }
}

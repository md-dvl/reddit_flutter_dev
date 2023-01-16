import 'package:dio/dio.dart';
import 'package:reddit_flutter_dev/models/post_model.dart';

class RedditRepo {
  final Dio dio;
  RedditRepo(this.dio);
  Future<PostModelInfoModel> getPosts() async {
    final result = await dio.get('');
    return PostModelInfoModel.fromJson(result.data);
  }
}

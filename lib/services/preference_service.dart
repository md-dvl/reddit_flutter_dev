import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static final PreferenceService _instance = PreferenceService._();
  late final SharedPreferences _prefs;
  PreferenceService._();
  factory PreferenceService() => _instance;
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  savePosts(List<String> posts) {
    _prefs.setStringList('posts', posts);
  }

  List<String> getPosts() {
    return _prefs.getStringList('posts') ?? [];
  }
}

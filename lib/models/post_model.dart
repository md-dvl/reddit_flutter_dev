class PostModelInfoModel {
  List<PostModel>? results;
  PostModelInfoModel(this.results);
  PostModelInfoModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      results = [];
      Map<String, dynamic> data = json['data'];
      data['children'].forEach((v) {
        results!.add(PostModel.fromJson(v['data']));
      });
    }
  }
}

class PostModel {
  String? title;
  String? selftext;
  String? thumbnail;
  String? ups;
  bool? isImage;
  PostModel({
    this.title,
    this.selftext,
    this.thumbnail,
    this.ups,
    this.isImage,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    selftext = json['selftext'];
    thumbnail = json['thumbnail'];
    ups = json['ups'].toString();
    isImage = (thumbnail == 'self' || thumbnail == 'default') ? false : true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['selftext'] = this.selftext;
    data['thumbnail'] = this.thumbnail;
    data['ups'] = this.ups;
    return data;
  }

  @override
  String toString() =>
      'PostModel(title: $title, thumbnail: $thumbnail, ups: $ups)';
}

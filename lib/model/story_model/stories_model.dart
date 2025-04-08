import 'dart:convert';

List<StoriesModel> storyModelFromJson(String str) {
  final jsonData = json.decode(str);
  return List<StoriesModel>.from(jsonData.map((x) => StoriesModel.fromJson(x)));
}

String storyModelToJson(List<StoriesModel> data) {
  final dyn = List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class StoriesModel {
  String storyId;
  String storyImg;
  String caption;
  String storyText;
  String storyTime;
  int viewers;
  int storyLikes;

  StoriesModel({
    this.storyId = '',
    this.storyImg = '',
    this.caption = '',
    this.storyText = '',
    this.storyTime = '',
    this.viewers = 0,
    this.storyLikes = 0,
  });

  factory StoriesModel.fromJson(Map<String, dynamic> json) => StoriesModel(
    storyId: json["story_id"] ?? '',
    storyImg: json["story_img"] ?? '',
    caption: json['caption'] ?? '',
    storyText: json["story_text"] ?? '',
    storyTime: json["story_time"] ?? '',
    viewers: json["viewers"] ?? 0,
    storyLikes: json["story_likes"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "story_id": storyId,
    "story_img": storyImg,
    'caption': caption,
    "story_text": storyText,
    "story_time": storyTime,
    "viewers": viewers,
    "story_likes": storyLikes,
  };
}
import 'dart:convert';

List<StoryModel> storyModelFromJson(String str) {
  final jsonData = json.decode(str);
  return List<StoryModel>.from(jsonData.map((x) => StoryModel.fromJson(x)));
}

String storyModelToJson(List<StoryModel> data) {
  final dyn = List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class StoryModel {
  String storyId;
  String uid;
  List storyImg;
  String caption;
  List storyText;
  String storyTime;
  int viewers;
  int storyLikes;

  StoryModel({
    this.storyId = '',
    this.uid = '',
    this.storyImg = const [],
    this.caption = '',
    this.storyText = const [],
    this.storyTime = '',
    this.viewers = 0,
    this.storyLikes = 0,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
    storyId: json["story_id"] ?? '',
    uid: json["uid"] ?? '',
    storyImg: List<String>.from(json["story_img"].map((x) => x)),
    caption: json['caption'] ?? '',
    storyText: List<String>.from(json["story_text"].map((x) => x)),
    storyTime: json["story_time"] ?? '',
    viewers: json["viewers"] ?? 0,
    storyLikes: json["story_likes"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "story_id": storyId,
    "uid": uid,
    "story_img": List<dynamic>.from(storyImg.map((x) => x)),
    'caption': caption,
    "story_text": List<dynamic>.from(storyText.map((x) => x)),
    "story_time": storyTime,
    "viewers": viewers,
    "story_likes": storyLikes,
  };
}
class TweetModerationRequestModel {
  TweetModerationRequestModel({this.twittId});

  int twittId;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "twittId": twittId,
    };
    return map;
  }
}

class TweetModerationResponseModel {
  final String message;

  TweetModerationResponseModel({this.message});

  factory TweetModerationResponseModel.fromJson(Map<String, dynamic> json){
    return TweetModerationResponseModel(message: json['message'] != null ? json['message'] : "");
  }
}

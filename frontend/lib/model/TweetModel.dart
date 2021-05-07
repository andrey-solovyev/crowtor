class TweetRequestModel {
  TweetRequestModel({this.textTwit});

  String textTwit;

  // String password;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "textTwit": textTwit.trim(),
      // "tagSet": null,
      // "premium": false
    };
    return map;
  }

  Set<String> getTagFromText() {
    Set<String> tag = Set();

    // tag.add("#COOL");
    // tag.add("#CROWTOR");

    return tag;
  }
}

class TweetResponseModel {
  final int id;
  final int amountLikes;
  final int amountDisLikes;
  final String created;
  final String textTwit;
  final String nickName;
  final bool premium;

  TweetResponseModel(
      {this.id,
      this.amountLikes,
      this.amountDisLikes,
      this.created,
      this.textTwit,
      this.nickName,
      this.premium});

  factory TweetResponseModel.fromJson(Map<String, dynamic> json) {
    return TweetResponseModel(
        id: json['id'] != null ? json['id'] : -1,
        amountLikes: json['amountLikes'] != null ? json['amountLikes'] : -1,
        amountDisLikes:
            json['amountDisLikes'] != null ? json['amountDisLikes'] : -1,
        created: json['created'] != null ? json['created'] : "",
        textTwit: json['textTwit'] != null ? json['textTwit'] : "",
        nickName: json['nickName'] != null ? json['nickName'] : "",
        premium: json['premium'] != null ? json['premium'] : false);
  }
}

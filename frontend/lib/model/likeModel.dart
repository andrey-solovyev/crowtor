class LikeRequestModel {
  LikeRequestModel({this.twittId});

  int twittId;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "twittId": twittId,
    };
    return map;
  }
}

class LikeResponseModel {
  final String message;

  LikeResponseModel({this.message});

  factory LikeResponseModel.fromJson(Map<String, dynamic> json){
    return LikeResponseModel(message: json['message'] != null ? json['message'] : "");
  }
}

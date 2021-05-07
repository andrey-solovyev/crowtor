class DisLikeRequestModel {
  DisLikeRequestModel({this.twittId});

  int twittId;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "twittId": twittId,
    };
    return map;
  }
}

class DisLikeResponseModel {
  final String message;

  DisLikeResponseModel({this.message});

  factory DisLikeResponseModel.fromJson(Map<String, dynamic> json){
    return DisLikeResponseModel(message: json['message'] != null ? json['message'] : "");
  }
}

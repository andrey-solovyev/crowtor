class DeleteTweetRequestModel {
  DeleteTweetRequestModel({this.twittId});

  int twittId;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "twittId": twittId,
    };
    return map;
  }
}

class DeleteTweetResponseModel {
  final String message;

  DeleteTweetResponseModel({this.message});

  factory DeleteTweetResponseModel.fromJson(Map<String, dynamic> json){
    return DeleteTweetResponseModel(message: json['message'] != null ? json['message'] : "");
  }
}

class UnSubscribeRequestModel {
  UnSubscribeRequestModel({this.subscribeUser});

  int subscribeUser;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "subscribeUser": subscribeUser,
    };
    return map;
  }
}

class UnSubscribeResponseModel {
  final String message;

  UnSubscribeResponseModel({this.message});

  factory UnSubscribeResponseModel.fromJson(Map<String, dynamic> json){
    return UnSubscribeResponseModel(message: json['message'] != null ? json['message'] : "");
  }
}

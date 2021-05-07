class SubscribeRequestModel {
  SubscribeRequestModel({this.subscribeUser});

  final int subscribeUser;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "subscribeUser": subscribeUser,
    };
    return map;
  }
}

class SubscribeResponseModel {
  final String message;

  SubscribeResponseModel({this.message});

  factory SubscribeResponseModel.fromJson(Map<String, dynamic> json){
    return SubscribeResponseModel(message: json['message'] != null ? json['message'] : "");
  }
}

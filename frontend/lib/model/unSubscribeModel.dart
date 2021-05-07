class UbSubscribeRequestModel {
  UbSubscribeRequestModel({this.subscribeUser});

  int subscribeUser;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "subscribeUser": subscribeUser,
    };
    return map;
  }
}

class UbSubscribeResponseModel {
  final String message;

  UbSubscribeResponseModel({this.message});

  factory UbSubscribeResponseModel.fromJson(Map<String, dynamic> json){
    return UbSubscribeResponseModel(message: json['message'] != null ? json['message'] : "");
  }
}

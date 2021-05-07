class LoginRequestModel {
  LoginRequestModel({this.email, this.password});

  String email;
  String password;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "email": email.trim(),
      "password": password.trim()
    };
    return map;
  }
}

class LoginResponseModel {
  final String token;
  final String error;

  LoginResponseModel({this.token, this.error});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json){
    return LoginResponseModel(token: json['token'] != null ? json['token'] : "", error: json['error'] != null ? json['error'] : "");
  }
}

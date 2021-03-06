class RegistrationRequestModel {
  RegistrationRequestModel(
      {this.email, this.password, this.firstName, this.lastName, this.bDay, this.nickName});

  String email;
  String password;
  String nickName;
  String firstName;
  String lastName;
  String bDay;

  String getFormatBDay() {
    List<String> splitBD = bDay.trim().split(".");

    print(splitBD[2] + "-" + splitBD[1] + "-" + splitBD[0] + "T12:12:12.012Z");

    return splitBD[2] + "-" + splitBD[1] + "-" + splitBD[0] + "T12:12:12.012Z";
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "email": email.trim(),
      "password": password.trim(),
      "nickName": nickName.trim(),
      "firstName": firstName.trim(),
      "lastName": lastName.trim(),
      "birthday": getFormatBDay()
    };
    return map;
  }
}

class RegistrationResponseModel {
  final String token;
  final String id;
  final String error;

  RegistrationResponseModel({this.token, this.id, this.error});

  factory RegistrationResponseModel.fromJson(Map<String, dynamic> json) {
    return RegistrationResponseModel(
        token: json['token'] != null ? json['token'] : "",
        id: json['id'] != null ?  json['id'].toString() : "",
        error: json['error'] != null ? json['error'] : ""
    );
  }
}

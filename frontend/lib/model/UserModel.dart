class UserRequestModel {
  UserRequestModel({this.id});

  int id;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "id": id,
    };
    return map;
  }
}

class UserResponseModel {
  UserResponseModel(
      {this.id,
        this.birthday,
        this.firstName,
        this.lastName,
        this.nickName,
        this.email,
        this.isDeleted,
        this.isPremium});

  final int id;
  final String birthday;
  final String firstName;
  final String lastName;
  final String nickName;
  final String email;
  final bool isDeleted;
  final bool isPremium;



  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
        id: json['id'] != null ? json['id'] : "",
        birthday: json['birthday'] != null ? json['birthday'] : "",
        firstName: json['firstName'] != null ? json['firstName'] : "",
        lastName: json['lastName'] != null ? json['lastName'] : "",
        nickName: json['nickName'] != null ? json['nickName'] : "",
        email: json['email'] != null ? json['email'] : "",
        isDeleted: json['isDeleted'] != null ? json['isDeleted'] : "",
        isPremium: json['isPremium'] != null ? json['isPremium'] : "");
  }
}

// class UserResponseModel {
//
//
//   final String token;
//   final String error;
//
//   UserResponseModel({this.token, this.error});
//
//
//
//   factory UserResponseModel.fromJson(Map<String, dynamic> json){
//     return UserResponseModel(token: json['token'] != null ? json['token'] : "", error: json['error'] != null ? json['error'] : "");
//   }
// }

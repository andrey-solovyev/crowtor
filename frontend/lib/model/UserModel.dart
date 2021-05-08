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

class UserRequestModelByNickName {
  UserRequestModelByNickName({this.nickName});

  String nickName;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "nickName": nickName.trim(),
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
      this.isPremium,
      this.subscription,
      this.subscribers,
      this.dateRegistration,
      this.twitts});

  final int id;
  final String birthday;
  final String firstName;
  final String lastName;
  final String nickName;
  final String email;
  final bool isDeleted;
  final bool isPremium;

  final int subscription;
  final int subscribers;
  final String dateRegistration;

  final List<dynamic> twitts;

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
        id: json['id'] != null ? json['id'] : -1,
        birthday: json['birthday'] != null
            ? json['birthday']
            : "12.12.12.12.12.12.12",
        firstName: json['firstName'] != null ? json['firstName'] : "",
        lastName: json['lastName'] != null ? json['lastName'] : "",
        nickName: json['nickName'] != null ? json['nickName'] : "",
        email: json['email'] != null ? json['email'] : "",
        dateRegistration: json['dateRegistration'] != null
            ? json['dateRegistration']
            : "12.12.12.12.12.12.12",
        subscribers: json['subscribers'] != null ? json['subscribers'] : 0,
        subscription: json['subscription'] != null ? json['subscription'] : 0,
        isDeleted: json['isDeleted'] != null ? json['isDeleted'] : false,
        twitts: json['twitts'] != null ? json['twitts'] : [],
        isPremium: json['isPremium'] != null ? json['isPremium'] : false);
  }
}

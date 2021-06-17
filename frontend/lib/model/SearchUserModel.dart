import 'package:crowtor/model/TweetModel.dart';
import 'package:crowtor/model/UserModel.dart';

class SearchUserRequestModel {
  SearchUserRequestModel({this.nickName});

  String nickName;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "nickName": nickName.trim(),
    };
    return map;
  }
}

class SearchUserResponseModel {
  List<UserResponseModel> users;

  SearchUserResponseModel({this.users});

  factory SearchUserResponseModel.fromJson(List<dynamic> json){

    List<UserResponseModel> allUsers = [];

    for(int i = 0; i < json.length; i++){
      allUsers.add(UserResponseModel.fromJson(json[i]));
    }

    return SearchUserResponseModel(users: allUsers);
  }
}
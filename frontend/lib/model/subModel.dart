import 'package:crowtor/model/UserModel.dart';

class FeedResponseModel {
  List<UserResponseModel> users;

  FeedResponseModel({this.users});

  factory FeedResponseModel.fromJson(List<dynamic> json){

    List<UserResponseModel> allUsers = [];

    for(int i = 0; i < json.length; i++){
      allUsers.add(UserResponseModel.fromJson(json[i]));
    }

    return FeedResponseModel(users: allUsers);
  }
}
import 'package:crowtor/api/apiService.dart';
import 'package:crowtor/model/UserModel.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  UserResponseModel userResponseModel;

  @override
  void initState() {
    super.initState();

    APIService apiService = new APIService();
    UserRequestModel requestModel = new UserRequestModel();
    requestModel.id = APIService.currUserId;
    apiService.getUser(requestModel).then((value) {
      userResponseModel = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text("Profile");
  }
}

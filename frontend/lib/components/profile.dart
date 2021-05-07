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

    // APIService apiService = new APIService();
    // apiService.getCurrentUser().then((value) {
    //   userResponseModel = value;
    //   print(userResponseModel.firstName);
    // }
    // );
  }

  @override
  Widget build(BuildContext context) {
    APIService apiService = new APIService();

    return FutureBuilder<UserResponseModel>(
      future: apiService.getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserResponseModel responseModel = snapshot.data;

          return Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  responseModel.firstName + " " + responseModel.lastName,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text("@" + responseModel.nickName,
                        style: TextStyle(fontSize: 18))),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                    child:
                    Row(
                      children: [
                      Icon(Icons.cake_outlined, size: 20,),
                      Text(
                        " Дата рождения: " +
                            responseModel.birthday.substring(0, 10), style: TextStyle(fontSize: 16),
                      )
                    ],)
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                    child:
                        Row(children: [
                          Icon(Icons.calendar_today_outlined, size: 20,),
                          Text(
                              " Дата регистрации: " + responseModel.dateRegistration.substring(0, 10), style: TextStyle(fontSize: 16),
                          )
                        ],)
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(responseModel.subscribers.toString() +
                            " подписчиков", style: TextStyle(fontSize: 20),),
                        Text(
                            responseModel.subscription.toString() + " подписок", style: TextStyle(fontSize: 20),)
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Твиты", style: TextStyle(fontSize: 18),),
                        Text("Нравиться", style: TextStyle(fontSize: 18),),
                        Text("Сохраненные", style: TextStyle(fontSize: 18),)
                      ],
                    )),
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

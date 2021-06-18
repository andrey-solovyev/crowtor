import 'package:crowtor/api/apiService.dart';
import 'package:crowtor/model/TweetModel.dart';
import 'package:crowtor/model/UserModel.dart';
import 'package:crowtor/model/disLikeModel.dart';
import 'package:crowtor/model/likeModel.dart';
import 'package:crowtor/model/subscribeModel.dart';
import 'package:crowtor/model/unSubscribeModel.dart';
import 'package:crowtor/screens/CommentScreen.dart';
import 'package:crowtor/screens/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'MyText.dart';

class UserMini extends StatefulWidget {
  UserMini({Key key, this.user}) : super(key: key);

  final UserResponseModel user;

  @override
  _UserMiniState createState() => _UserMiniState();
}

class _UserMiniState extends State<UserMini> {
  APIService apiService = new APIService();
  bool _isSubscribed = false;
  bool _isChanged = false;

  void _changeSub(isSub) {
    setState(() {
      _isChanged = true;
      _isSubscribed = isSub;
    });
  }
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  // }

  @override
  Widget build(BuildContext context) {

    if (!_isChanged) {
      _changeSub(widget.user.isSubscribed);
    }

    print("is" + _isSubscribed.toString());

    return GestureDetector(
        onTap: () {
          if (widget.user.nickName != APIService.currUserNickName) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Profile(
                          nickName: widget.user.nickName,
                        )));
            print("OPEN OTHER USER PROFILE" +
                widget.user.nickName +
                " " +
                APIService.currUserNickName);
          }
        },
        child: Container(
            margin: EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
            padding: EdgeInsets.fromLTRB(12.0, 6, 12.0, 0),
            decoration: BoxDecoration(
              border: Border.all(
                color: false ? Colors.yellow : Colors.red[200],
                width: false ? 3 : 1,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.user.firstName +
                                  " " +
                                  widget.user.lastName,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                              child: Text("@" + widget.user.nickName),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                              child: SizedBox(
                                child: _isSubscribed
                                    ? ElevatedButton(
                                        child: Text("Отписаться"),
                                        onPressed: () {
                                          apiService
                                              .unSubscribe(UnSubscribeRequestModel(
                                                  subscribeUser:
                                                      widget.user.id))
                                              .then((value) {

                                            print("User id - " +
                                                widget.user.id.toString() +
                                                " message: " +
                                                value.message);

                                            Get.snackbar(
                                              "Отписка",
                                              " на @" + widget.user.nickName,
                                            );
                                            _changeSub(false);
                                          });
                                        },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.purple,
                                  ),
                                      )
                                    : ElevatedButton(
                                        child: Text("Подписаться"),
                                        onPressed: () {
                                          apiService
                                              .subscribe(SubscribeRequestModel(
                                                  subscribeUser:
                                                      widget.user.id))
                                              .then((value) {

                                            print("User id - " +
                                                widget.user.id.toString() +
                                                " message: " +
                                                value.message);

                                            _changeSub(true);

                                            Get.snackbar(
                                              "Подписка",
                                              " на @" + widget.user.nickName,
                                            );
                                          });
                                        },
                                      ),
                                width: MediaQuery.of(context).size.width * 0.87,
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ],
            )));
  }
}

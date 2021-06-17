import 'package:crowtor/api/apiService.dart';
import 'package:crowtor/model/TweetModel.dart';
import 'package:crowtor/model/UserModel.dart';
import 'package:crowtor/model/disLikeModel.dart';
import 'package:crowtor/model/feedModel.dart';
import 'package:crowtor/model/likeModel.dart';
import 'package:crowtor/screens/CommentScreen.dart';
import 'package:crowtor/screens/profileScreen.dart';
import 'package:flutter/material.dart';

import 'MyText.dart';

class Comment extends StatefulWidget {
  Comment({Key key, this.nickName, this.commentText}) : super(key: key);

  final String nickName;
  final String commentText;

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  APIService apiService = new APIService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Text(widget.nickName + " " + widget.commentText);
    return GestureDetector(
        onTap: () {
          // print("OPEN TWEET");
        },
        child: Container(
            margin: EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
            padding: EdgeInsets.fromLTRB(12.0, 12, 12.0, 0),
            decoration: BoxDecoration(
              border: Border.all(
                color: false ? Colors.yellow : Colors.red[200],
                width: false ? 3 : 1,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  child:



                  FutureBuilder<UserResponseModel>(
                    future: apiService.getUserByNickName(
                        UserRequestModelByNickName(nickName: widget.nickName)),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        UserResponseModel responseModel = snapshot.data;

                        FeedResponseModel feedResponseModel =
                        FeedResponseModel.fromJson(snapshot.data.twitts);

                        return new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                responseModel.firstName + " " + responseModel.lastName,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                                child: Text("@" + responseModel.nickName), //+ widget.tweet.nickName
                              ),
                            ]);
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                  child: Text(
                    widget.commentText,
                  ),
                ),
              ],
            )));
  }
}

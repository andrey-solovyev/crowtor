import 'dart:io';

import 'package:crowtor/api/apiService.dart';
import 'package:crowtor/components/comment.dart';
import 'package:crowtor/components/progressHUD.dart';
import 'package:crowtor/components/tweet.dart';
import 'package:crowtor/model/CommentModel.dart';
import 'package:crowtor/model/TweetModel.dart';
import 'package:crowtor/model/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentScreen extends StatefulWidget {

  final TweetResponseModel tweet;

  CommentScreen({this.tweet});

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  bool isApiCallProcess = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();
  CommentRequestModel requestModel = new CommentRequestModel();


  @override
  Widget build(BuildContext context) {
    return ProgressHUD(child: _uiSetup(context), inAsyncCall: isApiCallProcess);
  }

  Widget _uiSetup(BuildContext context) {

    List<Widget> comments = [];

    for (var comment in widget.tweet.comments){
      comments.add(Comment(commentText: comment.textComment, nickName: comment.nickname,));
    }

    APIService apiService = new APIService();

    return Scaffold(
      appBar: AppBar(
        title: Text("Crowtor"),
      ),
      body: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              // shrinkWrap: true,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  child: Tweet(tweet: widget.tweet),
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                ),
                Padding(
                  child: TextFormField(
                    controller: textController,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    minLines: 2,
                    maxLines: 10,
                    decoration: InputDecoration(
                        hintText: "Ваш гениальный комментарий",
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(new Radius.circular(12.0))),
                        labelStyle: TextStyle(color: Colors.black)),
                    validator: (String value) {
                      if (value == null || value.isEmpty) {
                        return 'Напишите что нибудь';
                      }
                      return null;
                    },
                  ),
                  padding: EdgeInsets.fromLTRB(12, 12, 12, 6),
                ),
                Padding(
                  child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text("Комментировать"),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isApiCallProcess = true;
                            });

                            requestModel.comment = textController.text;
                            requestModel.twittId = widget.tweet.id;

                            APIService apiService = new APIService();
                            apiService.comment(requestModel).then((value) {
                              setState(() {
                                isApiCallProcess = false;
                              });
                              Get.snackbar(
                                "Комментарий",
                                "Успешно оставлен",
                              );
                              textController.text = "";
                              // Navigator.pushNamedAndRemoveUntil(context, "/feed", (route) => false);
                            }
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(),
                      )),
                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                ),
                Padding(


                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      return Padding(padding: EdgeInsets.fromLTRB(0, 12, 0, 0), child: comments[index],);
                    },
                  ),


                  padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
                ),
              ],
            ),
          )),
    );
  }
}

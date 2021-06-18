import 'dart:io';

import 'package:crowtor/api/apiService.dart';
import 'package:crowtor/components/progressHUD.dart';
import 'package:crowtor/model/TweetModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class AddNewTweetScreen extends StatefulWidget {

  AddNewTweetScreen({this.initialText});

  final String initialText;

  @override
  _AddNewTweetScreenState createState() => _AddNewTweetScreenState();
}

class _AddNewTweetScreenState extends State<AddNewTweetScreen> {
  bool isApiCallProcess = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();
  TweetRequestModel requestModel = new TweetRequestModel();

  @override
  Widget build(BuildContext context) {
    MyApp.analytics.logEvent(name: "Add_new_tweet_screen");



    return ProgressHUD(child: _uiSetup(context), inAsyncCall: isApiCallProcess);
  }

  Widget _uiSetup(BuildContext context) {

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
              child: TextFormField(
                // initialValue: "qweqwe",
                controller: textController..text = widget.initialText,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 12,
                maxLines: 100,
                decoration: InputDecoration(
                    hintText: "Что нового?",
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
              padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
            ),
            Padding(
              child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text("Опубликовать"),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          isApiCallProcess = true;
                        });

                        MyApp.analytics.logEvent(name: "Send_twit");

                        requestModel.textTwit = textController.text;
                        APIService apiService = new APIService();
                        apiService.createTweet(requestModel).then((value) {
                          setState(() {
                            isApiCallProcess = false;
                          });
                          Navigator.pushNamedAndRemoveUntil(context, "/feed", (route) => false);
                        }
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(),
                  )),
              padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
            ),
          ],
        ),
      )),
    );
  }
}

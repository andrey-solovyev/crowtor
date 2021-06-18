import 'package:crowtor/api/apiService.dart';
import 'package:crowtor/components/TweetForModeration.dart';
import 'package:crowtor/components/UserMini.dart';
import 'package:crowtor/components/tweet.dart';
import 'package:crowtor/model/SearchUserModel.dart';
import 'package:crowtor/model/TweetModel.dart';
import 'package:crowtor/model/feedModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SubsScreen extends StatefulWidget {
  const SubsScreen({Key key, this.isSubscribers}) : super(key: key);

  final bool isSubscribers;

  @override
  _SubsScreenState createState() => _SubsScreenState();
}

class _SubsScreenState extends State<SubsScreen> {
  @override
  Widget build(BuildContext context) {

    MyApp.analytics.logEvent(name: "Subs_screen");

    List<Widget> users = [];

    APIService apiService = new APIService();

    return Scaffold(
      appBar: AppBar(
        title: Text("Crowtor"),
      ),
      body: FutureBuilder<SearchUserResponseModel>(
        future: widget.isSubscribers
            ? apiService.getSubscribers(
                SearchUserRequestModel(nickName: APIService.currUserNickName))
            : apiService.getSubscriptions(
                SearchUserRequestModel(nickName: APIService.currUserNickName)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            SearchUserResponseModel responseModel = snapshot.data;

            users.clear();

            for (int i = 0; i < responseModel.users.length; i++) {
              users.add(UserMini(user: responseModel.users[i]));
            }

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: widget.isSubscribers
                      ? Text("Подписчики", style: TextStyle(fontSize: 24),)
                      :   Text("Подписки", style: TextStyle(fontSize: 24),),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                      child: users[index],
                    );
                  },
                )
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

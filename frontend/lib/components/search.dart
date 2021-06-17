import 'package:crowtor/api/apiService.dart';
import 'package:crowtor/components/UserMini.dart';
import 'package:crowtor/components/tweet.dart';
import 'package:crowtor/model/SearchUserModel.dart';
import 'package:crowtor/model/feedModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'feed.dart';

class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  APIService apiService = new APIService();
  List<Widget> tweets = [];
  List<Widget> users = [];

  bool userSearch = true;
  String searchText = "";

  void _setSearch(newUserSearch){
    setState(() {
      userSearch = newUserSearch;
    });
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Form(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                child: TextFormField(
                  // controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: "Поиск",
                      hintText: "Введите интересующий вас запрос"),
                  validator: (String value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите запрос';
                    }
                    return null;
                  },
                ),
                padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
              ),

              Padding(
                child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text("Найти твит"),
                      onPressed: () {
                        _setSearch(false);
                      },
                      style: ElevatedButton.styleFrom(),
                    )),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              ),

              Padding(
                child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text("Найти пользователя"),
                      onPressed: () {
                        _setSearch(true);
                      },
                      style: ElevatedButton.styleFrom(),
                    )),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              ),
            ],
          ),
        ),
        userSearch ? buildUsers(context, searchText) : buildTweets(context),
      ],
    );
    //     }
    //     return Center(child: CircularProgressIndicator());
    //   },
    // );
  }

  Widget buildUsers(BuildContext context, String nickname) {
    // return Text("User");

    return FutureBuilder<SearchUserResponseModel>(
      future: apiService.searchUser(SearchUserRequestModel(nickName: nickname)),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          SearchUserResponseModel responseModel = snapshot.data;

          users.clear();

          for (int i = 0; i < responseModel.users.length; i++){
            users.add(UserMini(user: responseModel.users[i]));
          }


          return ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Padding(padding: EdgeInsets.fromLTRB(0, 12, 0, 0), child: users[index],);
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );

  }

  Widget buildTweets(BuildContext context) {
    // return Text("Tweets");
    return FutureBuilder<FeedResponseModel>(
      future: apiService.getAllTweets(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          tweets.clear();


          FeedResponseModel responseModel = snapshot.data;
          for (int i = 0; i < responseModel.tweets.length; i++){
            tweets.add(Tweet(tweet: responseModel.tweets[i],));
          }

          print(responseModel.tweets.length);
          print(tweets.length);

          return ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: tweets.length,
            itemBuilder: (context, index) {
              return Padding(padding: EdgeInsets.fromLTRB(0, 12, 0, 0), child: tweets[index],);
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

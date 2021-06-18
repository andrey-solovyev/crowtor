import 'package:crowtor/api/apiService.dart';
import 'package:crowtor/components/UserMini.dart';
import 'package:crowtor/components/tweet.dart';
import 'package:crowtor/model/SearchUserModel.dart';
import 'package:crowtor/model/feedModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'feed.dart';

class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController textController = TextEditingController();
  APIService apiService = new APIService();
  List<Widget> tweets = [];
  List<Widget> users = [];

  bool isSearched = false;

  bool userSearch = true;
  String searchText = "";

  void _setFirstSearch() {
    setState(() {
      isSearched = true;
    });
  }

  void _setSearch(newUserSearch) {
    setState(() {
      userSearch = newUserSearch;
    });
  }

  void _searchText(newSearchText) {
    setState(() {
      searchText = newSearchText;
    });
  }

  @override
  Widget build(BuildContext context) {
    MyApp.analytics.logEvent(name: "Feed_screen");
    return ListView(
      children: [
        Form(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                child: TextFormField(
                  controller: textController,
                  // controller: emailController,
                  keyboardType: TextInputType.text,
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
                        _setFirstSearch();
                        _searchText(textController.text);
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
                        _setFirstSearch();
                        _setSearch(true);
                        _searchText(textController.text);
                      },
                      style: ElevatedButton.styleFrom(),
                    )),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              ),
            ],
          ),
        ),
        isSearched ? (userSearch ? buildUsers(context, searchText) : buildTweets(context, searchText)) : Text(""),
      ],
    );
  }

  Widget buildUsers(BuildContext context, String nickname) {
    // return Text("User");

    return FutureBuilder<SearchUserResponseModel>(
      future: apiService.searchUser(SearchUserRequestModel(nickName: nickname)),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          SearchUserResponseModel responseModel = snapshot.data;

          users.clear();

          for (int i = 0; i < responseModel.users.length; i++) {
            users.add(UserMini(user: responseModel.users[i]));
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                child: users[index],
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildTweets(BuildContext context, String text) {
    // return Text("Tweets");
    return FutureBuilder<FeedResponseModel>(
      future: apiService.searchTweets(text),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          tweets.clear();

          FeedResponseModel responseModel = snapshot.data;
          for (int i = 0; i < responseModel.tweets.length; i++) {
            tweets.add(Tweet(
              tweet: responseModel.tweets[i],
            ));
          }

          print(responseModel.tweets.length);
          print(tweets.length);

          return ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: tweets.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                child: tweets[index],
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

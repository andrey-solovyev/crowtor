import 'package:crowtor/api/apiService.dart';
import 'package:crowtor/components/tweet.dart';
import 'package:crowtor/model/UserModel.dart';
import 'package:crowtor/model/feedModel.dart';
import 'package:crowtor/screens/ModerationScreen.dart';
import 'package:crowtor/screens/SubsScreen.dart';
import 'package:crowtor/screens/loginScreen.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  UserResponseModel userResponseModel;
  Widget currentBottomTweets;
  List<Widget> userTweets = [];
  List<Widget> likedTweets = [];
  List<Widget> savedTweets = [];

  bool _isUserTweets = true;
  bool _isLikedTweets = false;
  bool _isSavedTweets = false;

  @override
  void initState() {
    super.initState();
  }

  void _setUserTweets() {
    setState(() {
      _isUserTweets = true;
      _isLikedTweets = false;
      _isSavedTweets = false;
    });
  }

  void _setLikedTweets() {
    setState(() {
      _isUserTweets = false;
      _isLikedTweets = true;
      _isSavedTweets = false;
    });
  }

  void _setSavedTweets() {
    setState(() {
      _isUserTweets = false;
      _isLikedTweets = false;
      _isSavedTweets = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    MyApp.analytics.logEvent(name: "Current_user_profile_screen");
    APIService apiService = new APIService();
    bool isModerator = false;

    apiService.getCurrentUser().then((value) {
      isModerator = value.roles.contains("MODERATOR_ROLE");
    });

    apiService.getCurrentUser().then((value) {
      isModerator = value.roles.contains("MODERATOR_ROLE");
    });

    List<Widget> tweets = [];
    return FutureBuilder<UserResponseModel>(
      future: apiService.getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserResponseModel responseModel = snapshot.data;

          userTweets.clear();

          apiService.getLikedTweets().then((value) {
            likedTweets.clear();
            for (int i = 0; i < value.tweets.length; i++) {
              likedTweets.add(Tweet(
                tweet: value.tweets[i],
              ));
            }
          });

          apiService.getSavedTweets().then((value) {
            savedTweets.clear();
            for (int i = 0; i < value.tweets.length; i++) {
              savedTweets.add(Tweet(
                tweet: value.tweets[i],
              ));
            }
          });

          FeedResponseModel feedResponseModel =
              FeedResponseModel.fromJson(snapshot.data.twitts);

          for (int i = 0; i < feedResponseModel.tweets.length; i++) {
            userTweets.add(Tweet(
              tweet: feedResponseModel.tweets[i],
            ));
          }

          return ListView(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      responseModel.firstName + " " + responseModel.lastName,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text("@" + responseModel.nickName,
                            style: TextStyle(fontSize: 18))),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.cake_outlined,
                              size: 20,
                            ),
                            Text(
                              " Дата рождения: " +
                                  responseModel.birthday.substring(0, 10),
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 20,
                            ),
                            Text(
                              " Дата регистрации: " +
                                  responseModel.dateRegistration
                                      .substring(0, 10),
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        )),
                    isModerator
                        ? Padding(
                            padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                            child: SizedBox(
                              child: ElevatedButton(
                                child: Text("Модерация"),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ModerationScreen()));
                                  print("Страница модерации");
                                },
                              ),
                              width: double.infinity,
                            ),
                          )
                        : Container(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: SizedBox(
                        child: ElevatedButton(
                            child: Text("Выйдти"),
                            onPressed: () {
                              apiService.logoutUser();
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/login', (route) => false);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                            )),
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SubsScreen(
                                              isSubscribers: true,
                                            )));
                              },
                              child: Text(
                                responseModel.subscribers.toString() +
                                    " подписчиков",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SubsScreen(
                                              isSubscribers: false,
                                            )));
                              },
                              child: Text(
                                responseModel.subscription.toString() +
                                    " подписок",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _setUserTweets();
                              },
                              child: Text(
                                "Твиты",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: _isUserTweets ? FontWeight.bold : FontWeight.normal),
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                _setLikedTweets();
                              },
                              child: Text(
                                "Нравится",
                                style: TextStyle(fontSize: 18, fontWeight: _isLikedTweets ? FontWeight.bold : FontWeight.normal),
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                _setSavedTweets();
                              },
                              child: Text(
                                "Сохраненные",
                                style: TextStyle(fontSize: 18, fontWeight: _isSavedTweets ? FontWeight.bold : FontWeight.normal),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              _isUserTweets ? buildCurrentTweets(userTweets) : (_isLikedTweets ? buildCurrentTweets(likedTweets) : buildCurrentTweets(savedTweets)),
            ],
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildCurrentTweets(tweets) {
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
}

import 'package:crowtor/api/apiService.dart';
import 'package:crowtor/components/tweet.dart';
import 'package:crowtor/model/UserModel.dart';
import 'package:crowtor/model/feedModel.dart';
import 'package:crowtor/screens/ModerationScreen.dart';
import 'package:crowtor/screens/SubsScreen.dart';
import 'package:crowtor/screens/loginScreen.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  UserResponseModel userResponseModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    APIService apiService = new APIService();
    bool isModerator = true;

    List<Widget> tweets = [];
    return FutureBuilder<UserResponseModel>(
      future: apiService.getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserResponseModel responseModel = snapshot.data;

          tweets.clear();

          FeedResponseModel feedResponseModel =
              FeedResponseModel.fromJson(snapshot.data.twitts);

          for (int i = 0; i < feedResponseModel.tweets.length; i++) {
            tweets.add(Tweet(
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
                              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
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
                            Text(
                              "Твиты",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Нравится",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "Сохраненные",
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        )),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: tweets.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                    child: tweets[index],
                  );
                },
              ),
            ],
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

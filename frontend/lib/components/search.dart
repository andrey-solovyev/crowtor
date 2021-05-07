import 'package:crowtor/api/apiService.dart';
import 'package:crowtor/components/tweet.dart';
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

  @override
  Widget build(BuildContext context) {

    // return FutureBuilder<FeedResponseModel>(
    //   future: apiService.getCurrentUser(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       UserResponseModel responseModel = snapshot.data;
    //
    //       FeedResponseModel feedResponseModel =
    //       FeedResponseModel.fromJson(snapshot.data);
    //
    //       for (int i = 0; i < feedResponseModel.tweets.length; i++) {
    //         tweets.add(Tweet(
    //           tweet: feedResponseModel.tweets[i],
    ////


    //         ));
    //       }

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
                            return 'Введите email';
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
                              print(APIService.token);
                            },
                            style: ElevatedButton.styleFrom(),
                          )),
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    ),
                    // Padding(
                    //   child: SizedBox(
                    //       width: double.infinity,
                    //       child: ElevatedButton(
                    //         child: Text("Найти человека"),
                    //         onPressed: (){},
                    //         style: ElevatedButton.styleFrom(),
                    //       )),
                    //   padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    // ),
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
    //     }
    //     return Center(child: CircularProgressIndicator());
    //   },
    // );


  }
}

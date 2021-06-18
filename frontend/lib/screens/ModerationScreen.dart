import 'package:crowtor/api/apiService.dart';
import 'package:crowtor/components/TweetForModeration.dart';
import 'package:crowtor/components/tweet.dart';
import 'package:crowtor/model/TweetModel.dart';
import 'package:crowtor/model/feedModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModerationScreen extends StatefulWidget {
  const ModerationScreen({Key key}) : super(key: key);

  @override
  _ModerationScreenState createState() => _ModerationScreenState();
}

class _ModerationScreenState extends State<ModerationScreen> {


  @override
  Widget build(BuildContext context) {
    List<Widget> tweets = [];

    APIService apiService = new APIService();

    return Scaffold(
      appBar: AppBar(
        title: Text("Crowtor"),
      ),
      body: FutureBuilder<FeedResponseModel>(
        future: apiService.getTweetsForModeration(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            tweets.clear();

            FeedResponseModel responseModel = snapshot.data;
            for (int i = 0; i < responseModel.tweets.length; i++) {
              tweets.add(TweetForModeration(tweet: responseModel.tweets[i],));
            }

            print(responseModel.tweets.length);
            print(tweets.length);

            return ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: tweets.length,
              itemBuilder: (context, index) {
                return Padding(padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: tweets[index],);
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

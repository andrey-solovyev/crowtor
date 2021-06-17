import 'package:crowtor/api/apiService.dart';
import 'package:crowtor/components/tweet.dart';
import 'package:crowtor/model/TweetModel.dart';
import 'package:crowtor/model/feedModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({Key key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {


  @override
  Widget build(BuildContext context) {

    List<Widget> tweets = [];

    APIService apiService = new APIService();

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

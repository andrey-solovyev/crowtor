import 'package:crowtor/model/TweetModel.dart';

class FeedResponseModel {
  List<TweetResponseModel> tweets;

  FeedResponseModel({this.tweets});

  factory FeedResponseModel.fromJson(List<dynamic> json){

    List<TweetResponseModel> allTweets = [];

    for(int i = 0; i < json.length; i++){
      allTweets.add(TweetResponseModel.fromJson(json[i]));
    }

    return FeedResponseModel(tweets: allTweets);
  }
}
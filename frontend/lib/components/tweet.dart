import 'package:crowtor/model/TweetModel.dart';
import 'package:flutter/material.dart';

import 'MyText.dart';

class Tweet extends StatefulWidget {
  Tweet({Key key, this.tweet}) : super(key: key);

  final TweetResponseModel tweet;

  @override
  _TweetState createState() => _TweetState();
}

class _TweetState extends State<Tweet> {

  int _amountLikes = 0;
  int _amountDisLikes = 0;
  bool isLiked = false;
  bool isDisliked = false;


  @override
  void initState() {
    super.initState();
    _amountLikes = widget.tweet.amountLikes;
    _amountDisLikes  = widget.tweet.amountDisLikes;

  }

  void _like() {
    setState(() {
      _amountLikes++;
    });
  }

  void _unLike() {
    setState(() {
      _amountLikes--;
    });
  }

  void _disLike() {
    setState(() {
      _amountDisLikes++;
    });
  }

  void _unDisLike() {
    setState(() {
      _amountDisLikes--;
    });
  }

  @override
  Widget build(BuildContext context) {



    return GestureDetector(
        onTap: () {
          print("OPEN TWEET");
        },
        child: Container(
            margin: EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
            padding: EdgeInsets.fromLTRB(12.0, 12, 12.0, 0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red[200],
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      print("OPEN OTHER USER PROFILE");
                    },
                    child: new Container(
                      child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Andrey Andrey",
                              style: TextStyle(fontSize: 20),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                              child: Text("@" + widget.tweet.nickName),
                            ),
                          ]),
                    )),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: MyText(
                    text: widget.tweet.textTwit,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(_amountLikes.toString()),

                        IconButton(
                          icon: Icon(Icons.thumb_up, color: isLiked ? Colors.red : Colors.grey[700],),
                          onPressed: () {
                            if (isLiked) {

                            } else {

                            }
                          },
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Text(_amountDisLikes.toString()),

                        IconButton(
                          icon: Icon(Icons.thumb_down, color: isDisliked ? Colors.black : Colors.grey[700],),
                          onPressed: () {
                            print("thumb_down");
                          },
                        ),
                      ],
                    ),

                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () {
                        print("comment");
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.ios_share),
                      onPressed: () {
                        print("ios_share");
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.bookmark),
                      onPressed: () {
                        print("bookmark");
                      },
                    ),
                  ],
                )
              ],
            )));
  }
}

import 'package:crowtor/api/apiService.dart';
import 'package:crowtor/model/TweetModel.dart';
import 'package:crowtor/model/TweetModerationModel.dart';
import 'package:crowtor/model/disLikeModel.dart';
import 'package:crowtor/model/likeModel.dart';
import 'package:crowtor/screens/CommentScreen.dart';
import 'package:crowtor/screens/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'MyText.dart';

class TweetForModeration extends StatefulWidget {
  TweetForModeration({Key key, this.tweet}) : super(key: key);

  final TweetResponseModel tweet;

  @override
  _TweetForModerationState createState() => _TweetForModerationState();
}

class _TweetForModerationState extends State<TweetForModeration> {
  int _amountLikes = 0;
  int _amountDisLikes = 0;
  bool isLiked = false;
  bool isDisliked = false;
  APIService apiService = new APIService();

  bool isAllowed;

  @override
  void initState() {
    super.initState();
    _amountLikes = widget.tweet.amountLikes;
    _amountDisLikes = widget.tweet.amountDisLikes;
    isLiked = widget.tweet.like;
    isDisliked = widget.tweet.dislike;

    isAllowed = false;

    print(widget.tweet.id.toString() +
        " " +
        widget.tweet.textTwit +
        " " +
        isLiked.toString() +
        " " +
        isDisliked.toString());
  }


  void _changeIsAllowed(isSub) {
    setState(() {
      isAllowed = isSub;
    });
  }


  void _like() {
    setState(() {
      _amountLikes++;
      isLiked = true;
    });

    apiService.likeTweet(LikeRequestModel(twittId: widget.tweet.id));

    if (isDisliked) {
      _unDisLike();
    }
  }

  void _unLike() {
    setState(() {
      _amountLikes--;
      isLiked = false;
    });
  }

  void _disLike() {
    setState(() {
      _amountDisLikes++;
      isDisliked = true;
    });

    apiService.disLikeTweet(DisLikeRequestModel(twittId: widget.tweet.id));

    if (isLiked) {
      _unLike();
    }
  }

  void _unDisLike() {
    setState(() {
      _amountDisLikes--;
      isDisliked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => CommentScreen(
                        tweet: widget.tweet,
                      )));
          print("OPEN TWEET");
        },
        child: Container(
            margin: EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
            padding: EdgeInsets.fromLTRB(12.0, 12, 12.0, 0),
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.tweet.premium ? Colors.yellow : Colors.red[200],
                width: widget.tweet.premium ? 3 : 1,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      if (widget.tweet.nickName !=
                          APIService.currUserNickName) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Profile(
                                      nickName: widget.tweet.nickName,
                                    )));
                        print("OPEN OTHER USER PROFILE" +
                            widget.tweet.nickName +
                            " " +
                            APIService.currUserNickName);
                      }
                    },
                    child: new Container(
                      child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tweet.firstName +
                                  " " +
                                  widget.tweet.lastName,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
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
                          icon: Icon(
                            Icons.thumb_up,
                            color: isLiked ? Colors.red : Colors.grey[700],
                          ),
                          onPressed: () {
                            if (isLiked) {
                              _unLike();
                            } else {
                              _like();
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(_amountDisLikes.toString()),
                        IconButton(
                          icon: Icon(
                            Icons.thumb_down,
                            color: isDisliked ? Colors.black : Colors.grey[700],
                          ),
                          onPressed: () {
                            if (isDisliked) {
                              _unDisLike();
                            } else {
                              _disLike();
                            }
                          },
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.comment,
                        color: Colors.grey[700],
                      ),
                      onPressed: () {
                        print(widget.tweet.nickName);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CommentScreen(
                                      tweet: widget.tweet,
                                    )));
                        print("comment");
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.ios_share,
                        color: Colors.grey[700],
                      ),
                      onPressed: () {
                        print(
                          "ios_share",
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.bookmark,
                        color: Colors.grey[700],
                      ),
                      onPressed: () {
                        print("bookmark");
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                  child: SizedBox(
                    child: isAllowed
                        ? ElevatedButton(
                            child: Text("Заблокировать"),
                            onPressed: () {
                              apiService
                                  .disAllowTweet(TweetModerationRequestModel(
                                      twittId: widget.tweet.id))
                                  .then((value) {
                                _changeIsAllowed(false);
                                        Get.snackbar(
                                          "Твит",
                                          "заблокирован " + value.message,
                                        );
                                      });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purple,
                            ),
                          )
                        : ElevatedButton(
                            child: Text("Одобрить"),
                            onPressed: () {
                              apiService
                                  .allowTweet(TweetModerationRequestModel(
                                      twittId: widget.tweet.id))
                                  .then((value) {
                                _changeIsAllowed(true);
                                Get.snackbar(
                                  "Твит",
                                  "одобрен " + value.message,
                                );
                              });
                              // apiService
                              //     .subscribe(SubscribeRequestModel(
                              //     subscribeUser:
                              //     widget.user.id))
                              //     .then((value) {
                              //
                              //
                              //
                              //   Get.snackbar(
                              //     "Твит",
                              //     "одобрен",
                              //   );
                              // });
                            },
                          ),
                    width: MediaQuery.of(context).size.width * 0.87,
                  ),
                ),
              ],
            )));
  }
}

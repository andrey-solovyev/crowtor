import 'package:crowtor/components/tweet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({Key key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  // List<Tweet> tweets = [];
  //
  // void addNewTweets() {
  //   setState(() {
  //     tweets.add(Tweet());
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    ScrollController controller;
    List<Widget> tweets = [];
    tweets.add(Tweet());
    tweets.add(Tweet());
    // tweets.add(Tweet());
    // tweets.add(Tweet());
    // tweets.add(Tweet());
    // tweets.add(Tweet());
    // tweets.add(Tweet());

    void _scrollListener() {
      print(controller.position.extentAfter);
      if (controller.position.extentAfter < 500) {
        setState(() {
          tweets.add(Tweet());
          // items.addAll(new List.generate(42, (index) => 'Inserted $index'));
        });
      }
    }

    @override
    void initState() {
      super.initState();
      controller = new ScrollController()..addListener(_scrollListener);
    }

    @override
    void dispose() {
      controller.removeListener(_scrollListener);
      super.dispose();
    }


    // final items = List<String>.generate(10000, (i) => "Item $i");

    return ListView.builder(
      controller: controller,
      itemCount: tweets.length,
      itemBuilder: (context, index) {
        return Padding(padding: EdgeInsets.fromLTRB(0, 12, 0, 0), child: tweets[index],);
      },
    );
    // FloatingActionButton(onPressed: addNewTweets, child: Text("qwe"),));
  }
}

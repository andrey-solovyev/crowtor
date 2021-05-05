import 'package:crowtor/components/tweet.dart';
import 'package:flutter/cupertino.dart';

class Feed extends StatefulWidget{
  const Feed({Key key}) : super(key: key);
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(height: 100,),
        Tweet(),
        // Tweet(),
        // Tweet(),
        // Tweet(),
      ],
    );
  }
}
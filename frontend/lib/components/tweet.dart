import 'package:flutter/material.dart';

import 'MyText.dart';

class Tweet extends StatefulWidget {
  @override
  _TweetState createState() => _TweetState();
}

class _TweetState extends State<Tweet> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            Text("Andrey Andrey", style: TextStyle(fontSize: 20),),
            Text("@AK20001701"),
            MyText(text: "Лорем ипсум #голор сит амет, @sohy, #миним\$ веритус",),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.thumb_up),
                  onPressed: () {
                    print("press");
                  },
                ),
                IconButton(
                  icon: Icon(Icons.thumb_down),
                  onPressed: () {
                    print("press");
                  },
                ),
                IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () {
                    print("press");
                  },
                ),
                IconButton(
                  icon: Icon(Icons.ios_share),
                  onPressed: () {
                    print("press");
                  },
                ),
                IconButton(
                  icon: Icon(Icons.bookmark),
                  onPressed: () {
                    print("press");
                  },
                ),
              ],
            )
          ],
        ));
  }
}

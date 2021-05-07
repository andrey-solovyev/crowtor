import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MyText extends StatefulWidget {
  const MyText({Key key, this.text}) : super(key: key);
  final String text;

  @override
  _TweetTextState createState() => _TweetTextState();
}

class _TweetTextState extends State<MyText> {
  void open(String text){
    if (text[0] == "#"){
      print("Open tag >>> " + text);
    }

    if (text[0] == "@") {
      print("Open person >>> " + text);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.text == null || widget.text.isEmpty) {
      return Text("");
    }

    List<TextSpan> spans = [];

    var splitText = widget.text.split(" ");
    for (String str in splitText) {
      String firstChar = str[0];
      String lastChar = str[str.length - 1];
      bool lastDeleted = false;

      if (".,!?<>{}&*)\$".contains(lastChar)){
        str = str.replaceAll(lastChar, "");
        lastDeleted = true;
      }

      if (firstChar == "#" || firstChar == "@") {
        spans.add(TextSpan(
            text: str,
            style: TextStyle(color: Colors.blue[400]),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                open(str);
              }
              ));
      } else {
        spans.add(TextSpan(text: str));
      }
      if (lastDeleted){
        spans.add(TextSpan(text: lastChar + " "));
      } else {
        spans.add(TextSpan(text: " "));
      }
    }

    return RichText(
      text: TextSpan(
        text: "",
        style: TextStyle(color: Colors.black),
        children: spans,
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySnackBar extends StatefulWidget {
  MySnackBar({this.text});

  final String text;

  @override
  _MySnackBarState createState() => _MySnackBarState();
}

class _MySnackBarState extends State<MySnackBar> {
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(widget.text),
    );
  }
}
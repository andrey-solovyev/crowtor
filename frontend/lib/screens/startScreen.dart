import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StartScreen extends StatefulWidget {
  StartScreen({Key key, this.text = "Добро пожаловать в наше приложение!", this.isFinalScreen = false})
      : super(key: key);

  final String text;
  final bool isFinalScreen;

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: widget.isFinalScreen
                      ? EdgeInsets.fromLTRB(5, 20, 5, 0)
                      : EdgeInsets.fromLTRB(5, 50, 5, 0),
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                    textAlign: TextAlign.center,
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: Column(
                    children: [
                      Padding(
                        child: SizedBox(
                          child: ElevatedButton(
                            child: widget.isFinalScreen
                                ? Text("Начать")
                                : Text("Далее"),
                            onPressed: widget.isFinalScreen
                                ? () => Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false)
                                : () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return StartScreen(
                                        text:
                                            'Данное приложение являеться аналогом твиттера и называеться crowtor',
                                        isFinalScreen: true,
                                      );
                                    }));
                                  },
                            style: ElevatedButton.styleFrom(),
                          ),
                          width: double.infinity,
                        ),
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      ),
                      widget.isFinalScreen ? SizedBox(height: 45,) : Padding(
                        child: SizedBox(
                          child: OutlinedButton(
                            child: Text("Пропустить"),
                            onPressed: () =>
                                // Navigator.pushNamed(context, '/login'),
                              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false),
                            style: OutlinedButton.styleFrom(
                              side:
                                  BorderSide(width: 2, color: Colors.redAccent),
                            ),
                          ),
                          width: double.infinity,
                        ),
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}

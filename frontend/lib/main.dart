import 'package:crowtor/api/apiService.dart';
import 'package:crowtor/screens/addNewTweet.dart';
import 'package:crowtor/screens/home.dart';
import 'package:crowtor/screens/loginScreen.dart';
import 'package:crowtor/screens/registrationScreen.dart';
import 'package:crowtor/screens/startScreen.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  static FirebaseAnalytics analytics = new FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = new FirebaseAnalyticsObserver(analytics: analytics);

  static final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {

    // GetMaterialApp
    return GetMaterialApp(
      title: 'Crowtor',
      theme: ThemeData(
        primarySwatch: Colors.red,

      ),
      initialRoute: "/",
      routes: {
        '/': (context) => StartScreen(),
        '/login': (context) => LoginScreen(),
        '/registration': (context) => RegistrationScreen(),
        '/feed': (context) => Home(),
        '/createTweet': (context) => AddNewTweetScreen(initialText: "",),
      },
      navigatorObservers: [
        observer,
      ],
      // navigatorKey: navigatorKey,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            MaterialButton(
              child: Text("To start screen"),
              color: Colors.amber,
              // onPressed: () => Get.to(() => StartScreen())
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return  StartScreen();
                }));
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

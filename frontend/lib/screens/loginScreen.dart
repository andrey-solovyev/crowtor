import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String errorMessage = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<http.Response> response;

  void setErrorMessage(String text) {
    setState(() {
      errorMessage = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crowtor"),
      ),
      body: Center(
          child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: "Email", hintText: "Введите email"),
                validator: (String value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите email';
                  }
                  if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return "Введите подходящий email";
                  }
                  return null;
                },
              ),
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            ),
            Padding(
              child: TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Пароль", hintText: "Введите пароль"),
                validator: (String value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите пароль';
                  }
                  return null;
                },
              ),
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            ),
            Padding(
              padding: errorMessage.isEmpty
                  ? EdgeInsets.fromLTRB(20, 0, 20, 0)
                  : EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                ),
              ),
            ),
            Padding(
              child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text("Войти"),
                    onPressed: () => {
                      if (_formKey.currentState.validate())
                        {
                          setErrorMessage("Пока вход не реализованн"),                           response = http.post(
                            Uri.https('127.0.0.1:5000', '/api/login'),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: jsonEncode(<String, String>{
                              'title': "TITLE1",
                            }),
                          )
                        }
                    },
                    style: ElevatedButton.styleFrom(),
                  )),
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            ),
            Padding(
              child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text("Зарегистрироваться"),
                    onPressed: () =>
                        Navigator.pushNamed(context, '/registration'),
                    style: ElevatedButton.styleFrom(),
                  )),
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            ),
            Padding(
              child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text("Продолжить как гость"),
                    onPressed: () => null,
                    style: ElevatedButton.styleFrom(),
                  )),
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            ),
          ],
        ),
      )),
    );
  }
}

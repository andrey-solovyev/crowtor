import 'dart:convert';

import 'package:crowtor/api/apiService.dart';
import 'package:crowtor/components/progressHUD.dart';
import 'package:crowtor/model/loginModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

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
  LoginRequestModel loginRequestModel;
  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
    loginRequestModel = new LoginRequestModel();
  }

  void _setErrorMessage(String text) {
    setState(() {
      errorMessage = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    MyApp.analytics.logEvent(name: "Login_screen");
    return ProgressHUD(child: _uiSetup(context), inAsyncCall: isApiCallProcess);
  }

  Widget _uiSetup(BuildContext context) {
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
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          isApiCallProcess = true;
                        });

                        loginRequestModel.password = passwordController.text;
                        loginRequestModel.email = emailController.text;

                        APIService apiService = new APIService();
                        apiService.login(loginRequestModel).then((value) {
                          setState(() {
                            isApiCallProcess = false;
                          });

                          if (value.token.isNotEmpty) {
                            onPressed:

                            print(APIService.token);
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/feed', (route) => false);
                          } else {
                            if (value.error.isNotEmpty) {
                              _setErrorMessage(value.error);
                            }
                          }
                        });
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
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                        context, '/feed', (route) => false),
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

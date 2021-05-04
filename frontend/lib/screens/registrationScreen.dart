import 'package:crowtor/api/apiService.dart';
import 'package:crowtor/components/progressHUD.dart';
import 'package:crowtor/model/registrationModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isApiCallProcess = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController bDayController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  RegistrationRequestModel registrationRequestModel;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    registrationRequestModel = new RegistrationRequestModel();
  }

  int _calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  _setErrorMessage(String text){
    setState(() {
      errorMessage = text;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    controller: nickNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Никнейм", hintText: "Введите никнейм"),
                    validator: (String value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите никнейм';
                      }
                      return null;
                    },
                  ),
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                ),
                Padding(
                  child: TextFormField(
                    controller: firstNameController,
                    keyboardType: TextInputType.text,
                    decoration:
                    InputDecoration(labelText: "Имя", hintText: "Введите имя"),
                    validator: (String value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите имя';
                      }
                      return null;
                    },
                  ),
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                ),
                Padding(
                  child: TextFormField(
                    controller: lastNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Фамилия", hintText: "Введите фамилию"),
                    validator: (String value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите фамилию';
                      }
                      return null;
                    },
                  ),
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                ),
                Padding(
                  child: TextFormField(
                    controller: bDayController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        labelText: "Дата рождения", hintText: "ДД.ММ.ГГГГ"),
                    validator: (String value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите дату рождения';
                      }
                      if (!RegExp(
                          r"^(3[01]|[12][0-9]|0?[1-9])\.(1[012]|0?[1-9])\.((?:19|20)\d{2})")
                          .hasMatch(value)) {
                        return "Введите корректную дату. Пример: 21.05.1999";
                      }
                      var dateList = value.split('.').map((e) => int.parse(e));
                      DateTime dt = DateTime.utc(dateList.elementAt(2),dateList.elementAt(1),dateList.elementAt(0));
                      int age = _calculateAge(dt);
                      if (age < 18) {
                        return "Возраст пользователя должен быть больше 18 лет.";
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
                  child: TextFormField(
                    controller: repeatPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Повторите пароль",
                        hintText: "Введите пароль"),
                    validator: (String value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите пароль';
                      }
                      if (value != passwordController.text){
                        return "Пароли не совпадают";
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
                        child: Text("Зарегистрироваться"),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isApiCallProcess = true;
                            });

                            registrationRequestModel.email = emailController.text;
                            registrationRequestModel.firstName = firstNameController.text;
                            registrationRequestModel.lastName = lastNameController.text;
                            registrationRequestModel.bDay = bDayController.text;
                            registrationRequestModel.password = passwordController.text;

                            print(registrationRequestModel.toJson());

                            APIService apiService = new APIService();
                            apiService.register(registrationRequestModel).then((value) {
                              setState(() {
                                isApiCallProcess = false;
                              });

                              if (value.token.isNotEmpty) {
                                _setErrorMessage(value.token + "\nADD REAL REG");
                              } else {
                                if (value.error.isNotEmpty) {
                                  _setErrorMessage(value.error);
                                }
                              }
                            });

                            // loginRequestModel.password = passwordController.text;
                            // loginRequestModel.email = emailController.text;
                            //
                            // APIService apiService = new APIService();
                            // apiService.login(loginRequestModel).then((value) {
                            //   setState(() {
                            //     isApiCallProcess = false;
                            //   });
                            //
                            //   if (value.token.isNotEmpty) {
                            //     _setErrorMessage(value.token + "\nADD REAL AUTH");
                            //   } else {
                            //     if (value.error.isNotEmpty) {
                            //       _setErrorMessage(value.error);
                            //     }
                            //   }
                            // });
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
                        child: Text("Войти"),
                        onPressed: () =>
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/login', (route) => false),
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

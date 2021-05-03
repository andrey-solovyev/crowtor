import 'package:crowtor/components/progressHUD.dart';
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
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();


  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return  ProgressHUD(child: _uiSetup(context), inAsyncCall: isApiCallProcess);
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
                    controller: firstNameController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "Имя", hintText: "Введите имя"),
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
                    keyboardType: TextInputType.emailAddress,
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
                    controller: lastNameController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        labelText: "Дата рождения", hintText: "ДД.ММ.ГГГГ"),
                    validator: (String value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите дату рождения';
                      }
                      return null;
                    },
                      // onTap: (){
                      //   FocusScope.of(context).requestFocus(new FocusNode());
                      // },
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
                        labelText: "Повторите пароль", hintText: "Введите пароль"),
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
                        child: Text("Зарегистрироваться"),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                        setState(() {
                              isApiCallProcess = true;
                            });

                            print(emailController.text + " " +firstNameController.text + " " +lastNameController.text + " " +passwordController.text + " " +repeatPasswordController.text + " ");

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
                            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false),
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

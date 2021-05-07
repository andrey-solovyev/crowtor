import 'package:crowtor/api/apiService.dart';
import 'package:crowtor/components/tweet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'feed.dart';

class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {


    return Center(
        child: Form(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                child: TextFormField(
                  // controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: "Поиск", hintText: "Введите интересующий вас запрос"),
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
                padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
              ),
              Padding(
                child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text("Найти твит"),
                      onPressed: () {
                        print(APIService.token);
                      },
                      style: ElevatedButton.styleFrom(),
                    )),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              ),
              Padding(
                child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text("Найти человека"),
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(),
                    )),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              ),
            ],
          ),
        ));
  }
}

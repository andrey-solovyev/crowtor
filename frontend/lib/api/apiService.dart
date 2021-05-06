import 'package:crowtor/model/UserModel.dart';
import 'package:crowtor/model/loginModel.dart';
import 'package:crowtor/model/registrationModel.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {

  static String token = "";
  static int currUserId = 1;


  final String serverUrl = "https://crowtor.herokuapp.com/api";
  final String apiVersion = "/v1";

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    Uri uri = Uri.parse(serverUrl + apiVersion + "/security/login");

    final response = await http.post(
        uri, headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestModel.toJson()));
    if (response.statusCode == 200 || response.statusCode == 400) {

      token = json.decode(response.body)["token"];

      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      return LoginResponseModel.fromJson(
          {"error": "Не удалось загрузить данные"});
    }
  }

  Future<RegistrationResponseModel> register(
      RegistrationRequestModel requestModel) async {
    Uri uri = Uri.parse(serverUrl + apiVersion + "/security/register");

    print(requestModel.toJson());

    final response = await http.post(
        uri, headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestModel.toJson()));

    // print(json.decode(response.body));
    print(response.statusCode);

    if (response.statusCode == 201) {
      return RegistrationResponseModel.fromJson({"error":"Вы успешно зарегестрировались!"});
    }

    if (response.statusCode == 200 || response.statusCode == 400) {
    return RegistrationResponseModel.fromJson(json.decode(response.body));
    } else {
    return RegistrationResponseModel.fromJson({"error":"Возникла проблема, повторите попытку позже"});
    }
  }

  Future<UserResponseModel> getUser(UserRequestModel requestModel) async {

  }
}
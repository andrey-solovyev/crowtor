import 'dart:convert';

import 'package:crowtor/main.dart';
import 'package:crowtor/model/TweetModel.dart';
import 'package:crowtor/model/UserModel.dart';
import 'package:crowtor/model/disLikeModel.dart';
import 'package:crowtor/model/feedModel.dart';
import 'package:crowtor/model/likeModel.dart';
import 'package:crowtor/model/loginModel.dart';
import 'package:crowtor/model/registrationModel.dart';
import 'package:crowtor/model/subscribeModel.dart';
import 'package:crowtor/model/unSubscribeModel.dart';
import 'package:crowtor/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class APIService {
  static String token = "";
  static int currUserId = 1;

  final String serverUrl = "https://crowtor.herokuapp.com/api";
  final String apiVersion = "/v1";

  void isAuthorized(){
    if (token == null || token.isEmpty) {
      // return MyApp.navigatorKey.currentState.pushNamedAndRemoveUntil("/login", (route) => false);
      print("qwe");
      Get.to(LoginScreen());
      // return MyApp.navigatorKey.currentState.pushNamed("/login");
      // pushNamedAndRemoveUntil("/login", (route) => false);
    }
  }

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    Uri uri = Uri.parse(serverUrl + apiVersion + "/security/login");

    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
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

    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestModel.toJson()));

    // print(json.decode(response.body));
    print(response.statusCode);

    if (response.statusCode == 201) {
      return RegistrationResponseModel.fromJson(
          {"error": "Вы успешно зарегестрировались!"});
    }

    if (response.statusCode == 200 || response.statusCode == 400) {
      return RegistrationResponseModel.fromJson(json.decode(response.body));
    } else {
      return RegistrationResponseModel.fromJson(
          {"error": "Возникла проблема, повторите попытку позже"});
    }
  }

  Future<UserResponseModel> getCurrentUser() async {
    // Get.to(LoginScreen());
    // isAuthorized();

    Uri uri = Uri.parse(serverUrl + apiVersion + "/person/currentUser");

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );

    return UserResponseModel.fromJson(json.decode(response.body));
  }

  Future<UserResponseModel> getUserByNickName(UserRequestModelByNickName requestModel) async {
    Uri uri = Uri.parse(serverUrl + apiVersion + "/person/getByNickName?nickName=" + requestModel.nickName);

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );

    return UserResponseModel.fromJson(json.decode(response.body));
  }

  Future<TweetResponseModel> createTweet(TweetRequestModel requestModel) async {
    Uri uri = Uri.parse(serverUrl + apiVersion + "/twitt/createTwit");
    final response = await http.post(uri,
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
        },
        body: jsonEncode(requestModel.toJson()));

    print(token);
    print(response.body);

    if (response.statusCode == 201) {
      return TweetResponseModel.fromJson({"message": "Твит успешно отправлен"});
    } else {
      return TweetResponseModel.fromJson({"message": "Что то пошло не так"});
    }
  }

  Future<FeedResponseModel> getAllTweets() async {
    Uri uri = Uri.parse(serverUrl + apiVersion + "/twitt/findAllTwitt");

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );

    return FeedResponseModel.fromJson(json.decode(response.body));
  }

  Future<LikeResponseModel> likeTweet(LikeRequestModel requestModel) async {
    Uri uri = Uri.parse(serverUrl + apiVersion + "/twitt/like?twittId=" + requestModel.twittId.toString());

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );

    if (response.statusCode == 201) {
      return LikeResponseModel.fromJson({"message":"Удачно"});
    } else {
      return LikeResponseModel.fromJson({"message":"Что то пошло не так"});
    }
  }

  Future<DisLikeResponseModel> disLikeTweet(DisLikeRequestModel requestModel) async {
    Uri uri = Uri.parse(serverUrl + apiVersion + "/twitt/dislike?twittId=" + requestModel.twittId.toString());

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );

    if (response.statusCode == 201) {
      return DisLikeResponseModel.fromJson({"message":"Удачно"});
    } else {
      return DisLikeResponseModel.fromJson({"message":"Что то пошло не так"});
    }
  }

  Future<SubscribeResponseModel> subscribe(SubscribeRequestModel requestModel) async {
    Uri uri = Uri.parse(serverUrl + apiVersion + "person/subscribe?subscribeUser=" + requestModel.subscribeUser.toString());

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 201) {
      return SubscribeResponseModel.fromJson({"message":"Удачно"});
    } else {
      return SubscribeResponseModel.fromJson({"message":"Что то пошло не так"});
    }
  }

  Future<UbSubscribeResponseModel> unSubscribe(UbSubscribeRequestModel requestModel) async {
    Uri uri = Uri.parse(serverUrl + apiVersion + "person/subscribe?subscribeUser=" + requestModel.subscribeUser.toString());

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );

    if (response.statusCode == 201) {
      return UbSubscribeResponseModel.fromJson({"message":"Удачно"});
    } else {
      return UbSubscribeResponseModel.fromJson({"message":"Что то пошло не так"});
    }
  }

}

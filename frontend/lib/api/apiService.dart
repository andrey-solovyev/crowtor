import 'dart:io';

import 'package:crowtor/model/TweetModel.dart';
import 'package:crowtor/model/UserModel.dart';
import 'package:crowtor/model/disLikeModel.dart';
import 'package:crowtor/model/feedModel.dart';
import 'package:crowtor/model/likeModel.dart';
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
}

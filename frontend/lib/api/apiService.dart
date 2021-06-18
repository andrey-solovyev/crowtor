import 'dart:convert';

import 'package:crowtor/components/MySnackBar.dart';
import 'package:crowtor/main.dart';
import 'package:crowtor/model/CommentModel.dart';
import 'package:crowtor/model/DeleteTweetModel.dart';
import 'package:crowtor/model/SearchUserModel.dart';
import 'package:crowtor/model/TweetModel.dart';
import 'package:crowtor/model/TweetModerationModel.dart';
import 'package:crowtor/model/UserModel.dart';
import 'package:crowtor/model/disLikeModel.dart';
import 'package:crowtor/model/feedModel.dart';
import 'package:crowtor/model/likeModel.dart';
import 'package:crowtor/model/loginModel.dart';
import 'package:crowtor/model/registrationModel.dart';
import 'package:crowtor/model/subscribeModel.dart';
import 'package:crowtor/model/unSubscribeModel.dart';
import 'package:crowtor/screens/loginScreen.dart';
import 'package:crowtor/screens/startScreen.dart';
import 'package:crowtor/services/AnalyticsService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class APIService {
  static String token = "";
  static String currUserNickName;
  // static AnalyticsService analyticsService = new AnalyticsService();

  final String serverUrl = "https://crowtor.herokuapp.com/api";
  final String apiVersion = "/v1";

  void log(response) {
    if (token != "") {
      print("token: " + token);
    }
    print("body: " + response.body);
    print("------------------------------------------------------------------"
        "---------------------------------------------------------------------"
        "---------------");
  }

  void isAuthorized() {
    if (token == null || token.isEmpty) {
      Future.microtask(() {
        Get.offAllNamed('/login');
        Get.snackbar(
          "Авторизация",
          "Для продолжения водите или зарегистрируйтесь",
        );
      });
    }
  }

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    Uri uri = Uri.parse(serverUrl + apiVersion + "/security/login");

    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestModel.toJson()));

    log(response);

    if (response.statusCode == 200 || response.statusCode == 400) {
      token = json.decode(response.body)["token"];
      getCurrentUser();
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      if (json.decode(response.body)["message"] ==
          "Invalid login or password") {
        return LoginResponseModel.fromJson(
            {"error": "Не верный логин или пароль"});
      }

      return LoginResponseModel.fromJson({"error": "Что то пошло не так..."});
    }
  }

  Future<RegistrationResponseModel> register(
      RegistrationRequestModel requestModel) async {
    Uri uri = Uri.parse(serverUrl + apiVersion + "/security/register");

    // print(requestModel.toJson());

    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestModel.toJson()));

    // print(json.decode(response.body));
    log(response);

    if (response.statusCode == 201) {
      return RegistrationResponseModel.fromJson(
          {"error": "Вы успешно зарегестрировались!"});
    }

    if (response.statusCode == 200 || response.statusCode == 400) {
      return RegistrationResponseModel.fromJson(json.decode(response.body));
    } else {
      if (json.decode(response.body)['message'] == "Email is exists!") {
        return RegistrationResponseModel.fromJson(
            {"error": "Пользователь с данным email уже зарегистрирован."});
      }

      if (json.decode(response.body)['message'] == "Nickname is exists!") {
        return RegistrationResponseModel.fromJson(
            {"error": "Данный никнейм уже занят."});
      }

      return RegistrationResponseModel.fromJson(
          {"error": "Возникла проблема, повторите попытку позже"});
    }
  }

  Future<UserResponseModel> getCurrentUser() async {
    isAuthorized();

    Uri uri = Uri.parse(serverUrl + apiVersion + "/person/currentUser");

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );

    log(response);

    currUserNickName = json.decode(response.body)["nickName"];

    return UserResponseModel.fromJson(json.decode(response.body));
  }

  Future<UserResponseModel> getUserByNickName(
      UserRequestModelByNickName requestModel) async {
    Uri uri = Uri.parse(serverUrl +
        apiVersion +
        "/person/getByNickName?nickName=" +
        requestModel.nickName);

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );

    log(response);

    return UserResponseModel.fromJson(json.decode(response.body));
  }

  Future<TweetResponseModel> createTweet(TweetRequestModel requestModel) async {
    isAuthorized();
    Uri uri = Uri.parse(serverUrl + apiVersion + "/twitt/createTwit");
    final response = await http.post(uri,
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
        },
        body: jsonEncode(requestModel.toJson()));

    log(response);

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

    print(response.statusCode);

    log(response);

    // print("token: " + token);
    // print(json.decode(response.body));

    return FeedResponseModel.fromJson(json.decode(response.body));
  }

  Future<FeedResponseModel> getLikedTweets() async {
    Uri uri = Uri.parse(serverUrl + apiVersion + "/twitt/getLikeTwitt");

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );

    print("Liked");

    log(response);

    // print("token: " + token);
    // print(json.decode(response.body));

    return FeedResponseModel.fromJson(json.decode(response.body));
  }

  Future<FeedResponseModel> getSavedTweets() async {
    Uri uri = Uri.parse(serverUrl + apiVersion + "/twitt/getSaveTwitt");

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );



    print(response.statusCode);

    log(response);

    // print("token: " + token);
    // print(json.decode(response.body));

    return FeedResponseModel.fromJson(json.decode(response.body));
  }

  Future<FeedResponseModel> getTweetsForModeration() async {
    Uri uri = Uri.parse(serverUrl + apiVersion + "/twitt/moderate");
    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );

    print(response.statusCode);
    log(response);

    return FeedResponseModel.fromJson(json.decode(response.body));
  }

  Future<TweetModerationResponseModel> disAllowTweet(
      TweetModerationRequestModel requestModel) async {

    isAuthorized();
    Uri uri = Uri.parse(serverUrl + apiVersion + "/twitt/disAccessTwitt?twittId=" +
        requestModel.twittId.toString());
    final response = await http.post(uri,
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
        },
        );
    log(response);

    if (response.statusCode == 200) {
      return TweetModerationResponseModel.fromJson({"message": "Удачно"});
    } else {
      return TweetModerationResponseModel.fromJson(
          {"message": "Что то пошло не так"});
    }
  }

  Future<TweetModerationResponseModel> allowTweet(
      TweetModerationRequestModel requestModel) async {

    isAuthorized();
    Uri uri = Uri.parse(serverUrl + apiVersion + "/twitt/accessTwitt?twittId=" +
        requestModel.twittId.toString());
    final response = await http.post(uri,
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
        },
    );
    log(response);

    if (response.statusCode == 200) {
      return TweetModerationResponseModel.fromJson({"message": "Удачно"});
    } else {
      return TweetModerationResponseModel.fromJson(
          {"message": "Что то пошло не так"});
    }
  }

  Future<DeleteTweetResponseModel> deleteTweet(
      DeleteTweetRequestModel requestModel) async {

    isAuthorized();
    Uri uri = Uri.parse(serverUrl + apiVersion + "/twitt/delete?twittId=" +
        requestModel.twittId.toString());
    final response = await http.delete(uri,
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
        });

    log(response);
    print(response.statusCode);

    if (response.statusCode == 200) {
      return DeleteTweetResponseModel.fromJson({"message": "Удачно"});
    } else {
      return DeleteTweetResponseModel.fromJson(
          {"message": "Что то пошло не так"});
    }
  }







  Future<LikeResponseModel> likeTweet(LikeRequestModel requestModel) async {
    isAuthorized();
    Uri uri = Uri.parse(serverUrl +
        apiVersion +
        "/twitt/like?twittId=" +
        requestModel.twittId.toString());

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );

    log(response);

    if (response.statusCode == 201) {
      return LikeResponseModel.fromJson({"message": "Удачно"});
    } else {
      return LikeResponseModel.fromJson({"message": "Что то пошло не так"});
    }
  }


  Future<DisLikeResponseModel> disLikeTweet(
      DisLikeRequestModel requestModel) async {
    isAuthorized();
    Uri uri = Uri.parse(serverUrl +
        apiVersion +
        "/twitt/dislike?twittId=" +
        requestModel.twittId.toString());

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );

    log(response);

    if (response.statusCode == 201) {
      return DisLikeResponseModel.fromJson({"message": "Удачно"});
    } else {
      return DisLikeResponseModel.fromJson({"message": "Что то пошло не так"});
    }
  }

  Future<LikeResponseModel> saveTweet(LikeRequestModel requestModel) async {
    isAuthorized();
    Uri uri = Uri.parse(serverUrl +
        apiVersion +
        "/twitt/saveTwitt?twittId=" +
        requestModel.twittId.toString());

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );

    log(response);

    if (response.statusCode == 201) {
      return LikeResponseModel.fromJson({"message": "Удачно"});
    } else {
      return LikeResponseModel.fromJson({"message": "Что то пошло не так"});
    }
  }

  Future<LikeResponseModel> deleteSavedTweet(LikeRequestModel requestModel) async {
    isAuthorized();
    Uri uri = Uri.parse(serverUrl +
        apiVersion +
        "/twitt/deleteSaveTwitt?twittId=" +
        requestModel.twittId.toString());

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );

    log(response);

    if (response.statusCode == 201) {
      return LikeResponseModel.fromJson({"message": "Удачно"});
    } else {
      return LikeResponseModel.fromJson({"message": "Что то пошло не так"});
    }
  }

  Future<CommentResponseModel> comment(CommentRequestModel requestModel) async {
    isAuthorized();
    Uri uri = Uri.parse(serverUrl + apiVersion + "/twitt/comment");
    final response = await http.post(uri,
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
        },
        body: jsonEncode(requestModel.toJson()));


    log(response);

    if (response.statusCode == 201) {
      return CommentResponseModel.fromJson({"message": "Твит успешно отправлен"});
    } else {
      return CommentResponseModel.fromJson({"message": "Что то пошло не так"});
    }
  }

  Future<SubscribeResponseModel> subscribe(
      SubscribeRequestModel requestModel) async {
    isAuthorized();
    Uri uri = Uri.parse(serverUrl +
        apiVersion +
        "/person/subscribe?subscribeUser=" +
        requestModel.subscribeUser.toString());

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );

    log(response);

    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 201) {
      return SubscribeResponseModel.fromJson({"message": "Удачно"});
    } else {
      return SubscribeResponseModel.fromJson(
          {"message": "Что то пошло не так"});
    }
  }

  Future<UnSubscribeResponseModel> unSubscribe(
      UnSubscribeRequestModel requestModel) async {
    isAuthorized();
    Uri uri = Uri.parse(serverUrl +
        apiVersion +
        "/person/unSubscribe?subscribeUser=" + requestModel.subscribeUser.toString());

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );

    log(response);

    if (response.statusCode == 201) {
      return UnSubscribeResponseModel.fromJson({"message": "Удачно"});
    } else {
      return UnSubscribeResponseModel.fromJson(
          {"message": "Что то пошло не так"});
    }
  }

  Future<SearchUserResponseModel> searchUser(
      SearchUserRequestModel requestModel) async {
    Uri uri = Uri.parse(serverUrl +
        apiVersion +
        "/person/search?nickName=" +
        requestModel.nickName);

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );

    log(response);

    return SearchUserResponseModel.fromJson(json.decode(response.body));
  }

  Future<SearchUserResponseModel> getSubscribers(
      SearchUserRequestModel requestModel) async {
    Uri uri = Uri.parse(serverUrl +
        apiVersion +
        "/person/getSubscribe?nickName=" +
        requestModel.nickName);

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );

    log(response);

    return SearchUserResponseModel.fromJson(json.decode(response.body));
  }

  Future<SearchUserResponseModel> getSubscriptions(
      SearchUserRequestModel requestModel) async {
    Uri uri = Uri.parse(serverUrl +
        apiVersion +
        "/person/getSubscription?nickName=" +
        requestModel.nickName);

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      },
    );

    log(response);

    return SearchUserResponseModel.fromJson(json.decode(response.body));
  }

  void metric(
      UnSubscribeRequestModel requestModel) async {
    isAuthorized();
    Uri uri = Uri.parse("https://api.appmetrica.yandex.com/logs/v1/import/events?"
        + "post_api_key=" + "85ca055e-50d2-45a6-a98f-180462654202"
      + "&application_id=" + "3996904"
        + "&event_name=" + "logout"
        + "&event_timestamp=" + DateTime.now().millisecondsSinceEpoch.toString()
    );

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json"
      },
    );

    log(response);
  }

  void logoutUser(){
    token = "";
    currUserNickName = "";
  }
}

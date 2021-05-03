import 'package:crowtor/model/loginModel.dart';
import 'package:crowtor/model/registrationModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {

  final String serverUrl = "https://reqres.in/api/";

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async{
    Uri uri = Uri.parse(serverUrl + "login");

    final response = await http.post(uri, body: requestModel.toJson());

    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
        throw Exception("Не удалось загрузить данные");
    }
  }

  Future<RegistrationResponseModel> register(RegistrationRequestModel requestModel) async{
    Uri uri = Uri.parse(serverUrl + "register");

    final response = await http.post(uri, body: requestModel.toJson());

    if (response.statusCode == 200 || response.statusCode == 400) {
      return RegistrationResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Не удалось загрузить данные");
    }
  }
}
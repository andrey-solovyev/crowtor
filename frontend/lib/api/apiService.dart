import 'package:crowtor/model/loginModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async{
    Uri uri = Uri.parse("https://reqres.in/api/login");

    final response = await http.post(uri, body: requestModel.toJson());

    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
        throw Exception("Не удалось загрузить данные");
    }
  }
}
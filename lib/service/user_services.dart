import 'dart:convert';
import 'package:chat_app/service/API.dart';
import 'package:http/http.dart' as http;

class UserServices {
  api _api = new api();
  late String token;

  Future loginUser(String _email, String _password) async {

    const subUrl = '/api/v1/user/login';
    var response = await http.post(
      Uri.parse("${_api.baseUrl}${subUrl}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": _email,
        "password": _password,
      }),
    );
    if (response.statusCode == 200)
    {
      var loginArr = json.decode(response.body);
      token = loginArr["data"]["token"];
      print("User services Token: $token");
      return token;
    }
    else
    {
      print("Status Code: ${response.statusCode}");
    }
  }
  Future registerUser(String _email, String _password, String _firstName, String _lastName) async {
    const subUrl = '/api/v1/user/register';
    var response = await http.post(
      Uri.parse("${_api.baseUrl}${subUrl}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": _email,
        "password": _password,
        "firstName":_firstName,
        "lastName":_lastName
      }),
    );
    if (response.statusCode == 200)
    {
      var loginArr = json.decode(response.body);
      bool succeded = loginArr["succeded"];
      return succeded;
    }
    else
    {
      print("Status Code: ${response.statusCode}");
    }
  }
}




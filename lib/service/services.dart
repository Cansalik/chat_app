import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Service {

  Future loginUser(String _email, String _password) async {
    const url = 'https://fiencrypted.azurewebsites.net/api/v1/user/login';
    print("$_email-----$_password");
    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": _email,
        "password": _password,
      }),
    );
    if (response.statusCode == 200)
    {
      var loginArr = json.decode(response.body);
      bool succeded = loginArr["succeded"];
      print(succeded);
      return succeded;
    }
    else
    {
      print("Status Code: ${response.statusCode}");
    }
  }
  Future registerUser(String _email, String _password, String _firstName, String _lastName) async {
    const url = 'https://fiencrypted.azurewebsites.net/api/v1/user/register';
    print("$_email---$_password---$_firstName----$_lastName");
    var response = await http.post(
      Uri.parse(url),
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




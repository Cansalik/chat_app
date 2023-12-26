import 'package:chat_app/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import '../service/services.dart';

class LoginRiverpod extends ChangeNotifier {
  final service = Service();

  void fetch(String _email, String _password)
  {
    service.loginUser(_email,_password).then((value) {
      if(value != null)
      {
        Grock.toRemove(homePage());
      }
      else
      {
        Grock.snackBar(title: "Hata", description: "Tekrar Dene",color: Colors.red);
      }
    });
  }

}

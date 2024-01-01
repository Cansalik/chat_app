import 'package:chat_app/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import '../service/user_services.dart';

class LoginRiverpod extends ChangeNotifier {
  final service = UserServices();

  void fetch(String _email, String _password)
  {
    service.loginUser(_email,_password).then((value) {
      if(value != null)
      {
        Grock.snackBar(title: "Giriş Başarılı", description: "");
        Grock.toRemove(homePage());
      }
      else
      {
        Grock.snackBar(title: "Hata", description: "Tekrar Deneyin",color: Colors.red);
      }
    });
  }

}

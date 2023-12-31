import 'package:chat_app/views/home_screen.dart';
import 'package:chat_app/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import '../service/user_services.dart';

class RegisterRiverpod extends ChangeNotifier {
  final service = UserServices();

  void fetch(String _email, String _password, String _firstName, _lastName)
  {
    service.registerUser(_email,_password,_firstName,_lastName).then((value) {
      if(value != null)
      {
        Grock.snackBar(title: "Kayıt Başarılı", description: "",color: Colors.greenAccent);
        Grock.toRemove(loginScreen());
      }
      else
      {
        Grock.snackBar(title: "Hata", description: "Tekrar Dene",color: Colors.red);
      }
    });
  }

}

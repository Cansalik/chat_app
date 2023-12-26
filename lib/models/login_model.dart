class LoginModel {
  bool succeded;
  Data data;

  LoginModel({
    required this.succeded,
    required this.data,
  });
}

class Data {
  String token;
  User user;

  Data({
    required this.token,
    required this.user,
  });

}

class User {
  String id;
  String firstName;
  String lastName;
  String email;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

}

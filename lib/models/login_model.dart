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
  String token;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.token
  });


  factory User.fromJson(Map<String, dynamic> e)
  {
    return User(
      id: e['id'],
      firstName: e['firstName'],
      lastName: e['lastName'],
      email: e['email'],
      token: e['token']
    );
  }
}

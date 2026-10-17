class LoginModel {
  final String? email;
  final String? accessToken;
  final String? refreshToken;
  LoginModel({this.accessToken, this.refreshToken, this.email});

  factory LoginModel.fromjson(Map<String, dynamic> json) {
    return LoginModel(
      email: json["user"]?["email"],
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
    );
  }
}

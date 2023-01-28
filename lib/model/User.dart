class User {
  String? _email;
  String? _password;


  User(this._email, this._password);

  User.fromJson(Map<String, dynamic> json) {
    _email = json['email'];
    _password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = _email;
    data['password'] = _password;
    return data;
  }
}

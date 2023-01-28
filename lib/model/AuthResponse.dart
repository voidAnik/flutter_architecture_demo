
class AuthResponse{
  String? _token;

  AuthResponse({String? token}) {
    if (token != null) {
      _token = token;
    }
  }

  String? get token => _token;
  set token(String? token) => _token = token;

  AuthResponse.fromJson(Map<String, dynamic> json) {
    _token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = _token;
    return data;
  }

 /* factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);*/

  @override
  String toString() {
    return 'AuthResponse{_token: $_token}';
  }
}
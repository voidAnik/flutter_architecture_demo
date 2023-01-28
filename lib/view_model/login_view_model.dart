

import 'package:flutter/material.dart';
import 'package:mvvm/model/AuthResponse.dart';
import 'package:mvvm/repository/auth_repository.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/user_session_view_model.dart';
import 'package:provider/provider.dart';

import '../locator.dart';
import '../model/User.dart';
import '../utils/messenger.dart';

class LoginViewModel with ChangeNotifier{
  String test = "Email";
  bool _loading = false;

  final _authRepo = getIt<AuthRepository>();
  bool get loading => _loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> login(BuildContext context, User user) async{
    setLoading(true);
    _authRepo.login_r(user).then((value){
      //AuthResponse authResponse = AuthResponse.fromJson(value);
      debugPrint(value.toString());
      //debugPrint(authResponse.toString());

      final userPref = UserSessionViewModel();
      userPref.saveUser(value);

      setLoading(false);
      Messenger.showToast(message: "Logged in successfully!", context: context);
      Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace){
      debugPrint(error.toString());
      setLoading(false);
      Messenger.flushBarError(error.toString(), context);
    });
  }

}
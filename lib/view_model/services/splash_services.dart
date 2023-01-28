import 'package:flutter/cupertino.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/user_session_view_model.dart';

import '../../model/AuthResponse.dart';

class SplashServices{

  Future<AuthResponse> getUserData() => UserSessionViewModel().getUser();

  void checkAuthentication(BuildContext context,[bool mounted = true])async{

    getUserData().then((value)async{
      final navigator = Navigator.of(context);
      await Future.delayed(const Duration(seconds: 3));
      debugPrint("auth checked");

      if(value.token == 'null' || value.token.toString().isEmpty){
        navigator.pushNamed(RoutesName.login);
      } else {
        navigator.pushNamed(RoutesName.home);
      }
    });
  }
}
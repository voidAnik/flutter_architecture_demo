import 'package:flutter/material.dart';
import 'package:mvvm/model/AuthResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../locator.dart';

class UserSessionViewModel with ChangeNotifier{

  //late SharedPreferences sharedPreferences;
  String tokenTag = 'token';

  Future<bool> saveUser(AuthResponse data) async{
    //SharedPreferences sharedPreferences = await getIt<Future<SharedPreferences>>();
    await getIt.isReady<SharedPreferences>();
    getIt<SharedPreferences>().setString(tokenTag, data.token.toString());
    notifyListeners();
    return true;
  }

  Future<AuthResponse> getUser() async{
    //SharedPreferences sharedPreferences = await getIt<Future<SharedPreferences>>();
    await getIt.isReady<SharedPreferences>();
    String? token = getIt<SharedPreferences>().getString(tokenTag);
    return AuthResponse(
      token: token.toString()
    );
  }

  Future<void> removeUser() async{
    //SharedPreferences sharedPreferences = await getIt<Future<SharedPreferences>>();
    await getIt.isReady<SharedPreferences>();
    getIt<SharedPreferences>().remove(tokenTag);
  }
}
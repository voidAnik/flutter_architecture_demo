import 'package:flutter/material.dart';
import 'package:mvvm/data/network/base_api_service.dart';
import 'package:mvvm/data/network/network_api_service.dart';
import 'package:mvvm/retro/client/retro_client.dart';
import 'package:dio/dio.dart';

import '../locator.dart';
import '../model/User.dart';
import '../res/api_url.dart';

class AuthRepository{

  final BaseApiService _apiService = NetworkApiService();

  Future<dynamic> login(dynamic data)async{
    try{
    dynamic response = await _apiService.postApiResponse(ApiUrl.loginUrl, data);
    return response;
    } catch(e){
      rethrow;
    }
  }

  Future<dynamic> login_r(User data)async{

    try{
      dynamic response = await getIt<RetroClient>().login(data);
      return response;
    } catch(e){

      rethrow;
    }
  }
}
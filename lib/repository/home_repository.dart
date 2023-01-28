import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../data/network/base_api_service.dart';
import '../data/network/network_api_service.dart';
import '../locator.dart';
import '../model/Photos.dart';
import '../res/api_url.dart';
import '../retro/client/retro_client.dart';

class HomeRepository{
  final BaseApiService _apiService = NetworkApiService();

  Future<List<Photos>> getPhotos()async{
    try{
      List response = await _apiService.getApiResponse(ApiUrl.getPhotosUrl);
      final List<Photos> photoList =
      response.map((item) => Photos.fromJson(item)).toList();
      return photoList;
    } catch(e){
      rethrow;
    }
  }

  Future<List<Photos>> getPhotos_r()async{
    try{
      List<Photos>  response = await getIt<RetroClient>().getPhotos();
      return response;
    } catch(e){
      rethrow;
    }
  }
}
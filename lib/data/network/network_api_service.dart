import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mvvm/data/app_exception.dart';
import 'package:mvvm/data/network/base_api_service.dart';
import 'package:http/http.dart' as client;

class NetworkApiService extends BaseApiService{
  @override
  Future getApiResponse(String uri) async{

    dynamic responseJson;
    try{
      final response = await client.get(Uri.parse(uri)).timeout(const Duration(seconds: 3));
      responseJson = returnResponse(response);
    } on SocketException{
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
  }

  @override
  Future postApiResponse(String uri, dynamic data) async{
    dynamic responseJson;
    try{
      final response = await client.post(
          Uri.parse(uri),
        body: data
      ).timeout(const Duration(seconds: 10));
      debugPrint("${response.statusCode} : ${response.body}");
      responseJson = returnResponse(response);
    } on SocketException{
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
  }

}

dynamic returnResponse(client.Response response){
  switch(response.statusCode){
    case 200:
      dynamic responseJson = jsonDecode(response.body);
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    default:
      throw FetchDataException("Error occurred while communicating with server with status code${response.statusCode}");
  }
}
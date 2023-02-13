import 'package:dio/dio.dart';

import '../../model/Photos.dart';
import '../../res/api_url.dart';

class DioClient {
  final Dio _dio = Dio();

  DioClient() {
    _dio.options = BaseOptions(
      baseUrl: "",
      receiveTimeout: 30000,
      connectTimeout: 30000,
      contentType: 'application/json',
      /* If needed headers */
      /* headers: {
            'Authorization': 'Basic ZGlzYXBpdXNlcjpkaXMjMTIz',
            'X-ApiKey': 'ZGslzIzEyMw==',
            'Content-Type': 'application/json'
          }*/
    );
  }

  Future<List<Photos>> getPhotos() async {
    Response<List<Photos>> response =
        await _dio.get<List<Photos>>(ApiUrl.getPhotosUrl);

    /*List<Photos> finalResponse = response.data!
        .map((dynamic i) => Photos.fromJson(i as Map<String, dynamic>))
        .toList();
    debugPrint(finalResponse.toString());*/
    return response.data!;
  }
}

import 'package:dio/dio.dart';
import 'package:mvvm/model/User.dart';
import 'package:retrofit/http.dart';

import '../../../model/AuthResponse.dart';
import '../../../model/Photos.dart';
import '../../../res/api_url.dart';

part 'retro_client.g.dart';

@RestApi(baseUrl: "")
abstract class RetroClient {
  factory RetroClient(Dio dio, {String? baseUrl}) {
    dio.options = BaseOptions(
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

    return _RetroClient(dio, baseUrl: baseUrl);
  }

  @POST(ApiUrl.loginUrl)
  Future<AuthResponse> login(@Body() User user);

  @GET(ApiUrl.getPhotosUrl)
  Future<List<Photos>> getPhotos();
}

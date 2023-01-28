abstract class BaseApiService {
  Future<dynamic> getApiResponse(String uri);

  Future<dynamic> postApiResponse(String uri, dynamic data);
}
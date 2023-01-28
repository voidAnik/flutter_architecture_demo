import 'package:mvvm/data/response/status.dart';
import 'package:http/http.dart' as http;

class ApiResponse<T>{

  Status? status;

  String? message;

  T? data;

  ApiResponse(this.status, this.message, this.data);

  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.completed(this.data) : status = Status.COMPLETED;
  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return 'ApiResponse{status: $status, message: $message, data: $data}';
  }
}
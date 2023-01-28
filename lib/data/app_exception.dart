
class AppException implements Exception{
  final _prefix;
  final _error;

  AppException(this._prefix, this._error);

  @override
  String toString() {
    return 'AppException{_prefix: $_prefix, _error: $_error}';
  }
}

class FetchDataException extends AppException{
  FetchDataException([String? error]) : super("FetchDataException", error);
}

class BadRequestException extends AppException{
  BadRequestException([String? error]) : super("BadRequestException", error);
}
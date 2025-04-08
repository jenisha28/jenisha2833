class AppException implements Exception {
  final dynamic prefix;
  final dynamic message;

  AppException([this.message, this.prefix]);

  @override
  String toString() {
    return '$prefix $message';
  }
}

class NetworkException extends AppException {
  NetworkException([String? message]) : super([message, 'No Internet']);
}

class RequestTimeOut extends AppException {
  RequestTimeOut([String? message]) : super([message, 'Request Time out']);
}

class ServerException extends AppException {
  ServerException([String? message])
      : super([message, 'Internet Server error']);
}

class InvalidUrlException extends AppException {
  InvalidUrlException([String? message])
      : super([message, 'Invalid Url Implemented']);
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super([message, 'Error while communicating with server']);
}

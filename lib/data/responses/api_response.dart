

import 'package:social_media_app/data/responses/status.dart';

class ApiResponse<T> {

  Status? status;
  T? data;
  String? message;

  ApiResponse(this.status, this.data, this.message);

  ApiResponse.loading() : status = Status.loading;
  ApiResponse.completed(this.data) : status = Status.completed;
  ApiResponse.error(this.message) : status = Status.error;
  ApiResponse.failure() : status = Status.failure;

  @override
  String toString() {
    return 'Status: $status \nData: $data \nMessage: $message';
  }
}
import 'dart:convert';
import 'dart:io';

import 'package:social_media_app/data/app_exceptions.dart';
import 'package:social_media_app/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {

  @override
  Future getApi(String url) async {
    dynamic jsonResponse;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NetworkException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }
    return jsonResponse;
  }

  @override
  Future postApi(var data, String url) async {
    dynamic jsonResponse;
    try {
      final response = await http
          .post(
            Uri.parse(url),
            body: jsonEncode(data),
          )
          .timeout(Duration(seconds: 10));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NetworkException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }
    return jsonResponse;
  }

  @override
  Future deleteApi(var data, String url) async {
    dynamic jsonResponse;
    try {
      final response =
          await http.delete(Uri.parse(url)).timeout(Duration(seconds: 10));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NetworkException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }
    return jsonResponse;
  }

  @override
  Future putApi(var data, String url) async {
    dynamic jsonResponse;
    try {
      final response = await http
          .put(
            Uri.parse(url),
            body: jsonEncode(data),
          )
          .timeout(Duration(seconds: 10));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NetworkException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }
    return jsonResponse;
  }

  @override
  Future patchApi(var data, String url) async {
    dynamic jsonResponse;
    try {
      final response = await http
          .patch(
            Uri.parse(url),
            body: jsonEncode(data),
          )
          .timeout(Duration(seconds: 10));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NetworkException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }
    return jsonResponse;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 400:
        throw InvalidUrlException();
      case 500:
        throw ServerException();
      default:
        throw FetchDataException();
    }
  }
}

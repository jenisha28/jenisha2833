import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:social_media_app/data/app_exceptions.dart';
import 'package:social_media_app/data/network/base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  final dio = Dio();

  @override
  // TODO: implement getApi
  Future getApi(String url) async {
    dynamic jsonResponse;
    try {
      final response = await dio.get(url).timeout(Duration(seconds: 10));
      // if (kDebugMode) {
      //   print(response.statusCode);
      // }
      jsonResponse = jsonDecode(returnResponse(response));
    } on SocketException {
      throw NetworkException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }
    return jsonResponse;
  }

  @override
  // TODO: implement postApi
  Future postApi(var data, String url) async {
    dynamic jsonResponse;
    try {
      final response =
          await dio.post(url, data: data).timeout(Duration(seconds: 30));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NetworkException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }
    return jsonResponse;
  }

  @override
  // TODO: implement deleteApi
  Future deleteApi(var data, String url) async {
    dynamic jsonResponse;
    try {
      final response = await dio.delete(url).timeout(Duration(seconds: 10));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NetworkException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }
    return jsonResponse;
  }

  @override
  // TODO: implement putApi
  Future putApi(var data, String url) async {
    dynamic jsonResponse;
    try {
      final response =
          await dio.put(url, data: data).timeout(Duration(seconds: 10));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NetworkException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }
    return jsonResponse;
  }

  @override
  // TODO: implement patchApi
  Future patchApi(var data, String url) async {
    dynamic jsonResponse;
    try {
      final response =
          await dio.patch(url, data: data).timeout(Duration(seconds: 10));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NetworkException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }
    return jsonResponse;
  }

  dynamic returnResponse(Response response) {
    if (kDebugMode) {
      print('Status Code: 🙂${response.statusCode}');
    }
    switch (response.statusCode) {
      case 200:
        dynamic jsonResponse = response.data;
        return jsonResponse;
      case 400:
        throw InvalidUrlException();
      case 500:
        throw ServerException();
      default:
        dynamic jsonResponse = response.data;
        return jsonResponse;
      // throw FetchDataException();
    }
  }
}

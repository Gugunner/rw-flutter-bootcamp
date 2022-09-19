import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pokedex/general_app_feature/api/app_api.dart';
import 'package:pokedex/general_app_feature/api/endpoints.dart';

///The app class that handles all [Dio] implementations,
///use this for all Dio http requests, configurations, interceptors and
///even certificate checks.
class AppDioApi implements AppApi {
  AppDioApi(this.dio) {
    dio.options
      //Dio default content-type is 'application/json; charset=utf-8'
      ..baseUrl = Endpoints.baseUrl
      ..headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      }
      ..connectTimeout = 5000 //5s
      ..receiveTimeout = 3000;
    //TODO: Add dio interceptor call to refresh auth token
  }

  final Dio dio;

  //Method for simple get requests with no parameters
  @override
  Future<Response> get(String path) async {
    return await dio.get(
        path);
  }

  @override
  Future getWithParameters(String path, Map<String, dynamic> parameters) {
    // TODO: implement getWithParameters
    throw UnimplementedError();
  }

  //TODO: Create a complex get request with parameters handling
}

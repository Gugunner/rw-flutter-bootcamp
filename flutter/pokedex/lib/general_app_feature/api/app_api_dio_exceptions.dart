import 'dart:io';

import 'package:dio/dio.dart';

///A specific implementation of api exceptions
///using [DioErrorType].
class AppDioApiExceptions implements Exception {
  late String message;

  ///A named constructor that takes a [dioError] 
  ///and based on the [type] creates an error message.
  AppDioApiExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = 'Request to API server was cancelled';
        break;
      case DioErrorType.connectTimeout:
        message = 'Connection timeout with API server';
        break;
      case DioErrorType.receiveTimeout:
        message = 'Receive timeout in connection with API server';
        break;
      case DioErrorType.response:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioErrorType.sendTimeout:
        message = 'Send timeout in connection with API server';
        break;
      case DioErrorType.other:
        if (dioError.message.contains('SocketException')) {
          message = 'No Internet';
          break;
        }
        message = 'Unexpected error occurred';
        break;
      default:
        message = 'Something went wrong';
        break;
    }
  }

  ///A specific handling of error based on the [statusCode] of
  ///the [Response]. Add cases as needed.
  String _handleError(int? statusCode, dynamic dataError) {
    switch (statusCode) {
      case HttpStatus.badRequest:
        return 'Bad request';
      case HttpStatus.unauthorized:
        return 'Unauthorized';
      case HttpStatus.forbidden:
        return 'Forbidden';
      case HttpStatus.notFound:
        return 'Not Found';
      case HttpStatus.conflict:
        return 'Conflict';
      case HttpStatus.internalServerError:
        return 'Internal server error';
      case HttpStatus.badGateway:
        return 'Bad gateway';
      default:
        return 'Other';
    }
  }

  ///Call this method to print the error message.
  @override
  String toString() => message;
}

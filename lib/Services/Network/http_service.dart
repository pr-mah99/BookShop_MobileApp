import 'package:dio/dio.dart';

import '../Constant/constant.dart';

class HttpService {
  final Dio _dio = Dio();

  HttpService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add authorization headers if available
        if (loginState) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        // Log request information
        print('Request: ${options.method} ${options.uri}');
        print('Headers: ${options.headers}');
        print('Data: ${options.data}');
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        // Log error information
        print('Error: ${e.message}');
        print('Response: ${e.response}');
        return handler.next(e);
      },
    ));
  }

  Future<Response> get(String url) async {
    try {
      print('Sending GET request to: $url');
      Response response = await _dio.get(
        serverName+url,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(String url, dynamic data) async {
    try {
      Response response = await _dio.post(
        serverName+url,
        data: data,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> put(String url, dynamic data) async {
    try {
      Response response = await _dio.put(
        serverName+url,
        data: data,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> delete(String url, dynamic data) async {
    try {
      Response response = await _dio.delete(
        serverName+url,
        data: data,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _handleError(DioException error) {
    if (error.response != null) {
      // Server error
      print('Server Error - Status Code: ${error.response?.statusCode}');
      print('Response Data: ${error.response?.data}');
      throw ServerException(error.response?.data['message'] ?? 'Server Error');
    } else {
      // Network or other errors
      print('Network Error: ${error.message}');
      throw NetworkException(
          'Failed to connect to the server. Please check your network.');
    }
  }
}

// Custom exceptions for error handling
class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);
}

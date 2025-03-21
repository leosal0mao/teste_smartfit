import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import '../errors/server_exception.dart';

class DioAdapter {
  final Dio dio;

  DioAdapter(this.dio) {
    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {
        'Accept': 'application/json',
      },
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    );

    dio.interceptors.add(LogInterceptor(
      request: true,
      responseBody: true,
      requestBody: true,
    ));
  }

  // Método GET
  Future<Map<String, dynamic>> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await dio.get(
        uri,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ServerException(message: 'Request timed out');
      }
      throw ServerException(
        message: e.response?.statusMessage ?? 'An error occurred',
      );
    }
  }

  // Método POST
  Future<Map<String, dynamic>> post(
    String uri, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ServerException(message: 'Request timed out');
      }
      throw ServerException(
        message: e.response?.statusMessage ?? 'An error occurred',
      );
    }
  }

  // Método PUT
  Future<Map<String, dynamic>> put(
    String uri, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ServerException(message: 'Request timed out');
      }
      throw ServerException(
        message: e.response?.statusMessage ?? 'An error occurred',
      );
    }
  }

  // Método DELETE
  Future<Map<String, dynamic>> delete(
    String uri, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ServerException(message: 'Request timed out');
      }
      throw ServerException(
        message: e.response?.statusMessage ?? 'An error occurred',
      );
    }
  }
}

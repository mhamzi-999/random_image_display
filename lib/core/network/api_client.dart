import 'package:dio/dio.dart';

/// Lightweight wrapper around [Dio] to keep networking concerns centralized.
class ApiClient {
  ApiClient({required Dio dio}) : _dio = dio;

  final Dio _dio;

  /// Performs a GET request and returns the raw [Response].
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }
}

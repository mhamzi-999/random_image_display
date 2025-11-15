import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/random_image_model.dart';

/// Contract for fetching random images from remote source.
abstract class RandomImageRemoteDataSource {
  Future<RandomImageModel> getRandomImage();
}

/// Implementation that hits the public backend using [ApiClient].
class RandomImageRemoteDataSourceImpl implements RandomImageRemoteDataSource {
  RandomImageRemoteDataSourceImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  static const _randomImagePath = '/image';

  final ApiClient _apiClient;

  @override
  Future<RandomImageModel> getRandomImage() async {
    try {
      final response =
          await _apiClient.get<Map<String, dynamic>>(_randomImagePath);
      final statusCode = response.statusCode ?? 500;

      if (statusCode != 200 || response.data == null) {
        throw ServerException(
          message: 'Failed to load image',
          statusCode: statusCode,
        );
      }

      return RandomImageModel.fromJson(response.data!);
    } on DioException catch (error) {
      if (_isConnectivityIssue(error)) {
        throw const NetworkException('Unable to reach the server');
      }

      throw ServerException(
        message: error.response?.statusMessage ?? 'Unexpected server error',
        statusCode: error.response?.statusCode,
      );
    } on ServerException {
      rethrow;
    } catch (_) {
      throw const UnexpectedException('Unexpected response received');
    }
  }

  bool _isConnectivityIssue(DioException error) {
    return error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.unknown;
  }
}

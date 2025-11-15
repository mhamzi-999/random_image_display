import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/random_image.dart';
import '../../domain/repositories/random_image_repository.dart';
import '../datasources/random_image_remote_data_source.dart';

/// Concrete implementation of [RandomImageRepository] backed by the remote API.
class RandomImageRepositoryImpl implements RandomImageRepository {
  RandomImageRepositoryImpl(
      {required RandomImageRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  final RandomImageRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, RandomImage>> getRandomImage() async {
    try {
      final model = await _remoteDataSource.getRandomImage();
      return Right(model);
    } on NetworkException catch (error) {
      return Left(
          NetworkFailure(error.message ?? 'Unable to reach the server'));
    } on ServerException catch (error) {
      return Left(
        ServerFailure(
          error.message ??
              'Received invalid response (${error.statusCode ?? 'unknown'})',
        ),
      );
    } on UnexpectedException catch (error) {
      return Left(
          UnexpectedFailure(error.message ?? 'Unexpected data from server'));
    } catch (_) {
      return const Left(UnexpectedFailure('Unexpected error occurred'));
    }
  }
}

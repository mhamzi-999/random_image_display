import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/random_image.dart';
import '../repositories/random_image_repository.dart';

/// Retrieves a random image from the backend.
class GetRandomImage extends UseCase<RandomImage, NoParams> {
  GetRandomImage(this.repository);

  final RandomImageRepository repository;

  @override
  Future<Either<Failure, RandomImage>> call(NoParams params) {
    return repository.getRandomImage();
  }
}

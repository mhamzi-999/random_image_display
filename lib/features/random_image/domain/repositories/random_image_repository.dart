import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/random_image.dart';

/// Repository contract describing how the app fetches random images.
abstract class RandomImageRepository {
  Future<Either<Failure, RandomImage>> getRandomImage();
}

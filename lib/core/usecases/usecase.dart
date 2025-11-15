import 'package:dartz/dartz.dart';

import '../error/failures.dart';

/// Base interface for all synchronous/asynchronous use-cases.
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Represents use-cases that do not require any input.
class NoParams {
  const NoParams();
}

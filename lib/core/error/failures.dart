import 'package:equatable/equatable.dart';

/// Base class for failures that can be surfaced to presentation.
abstract class Failure extends Equatable {
  /// Human-readable message describing the failure.
  final String message;

  /// Optional details for logging/debugging.
  final String? details;

  const Failure(this.message, {this.details});

  @override
  List<Object?> get props => [message, details];
}

/// Generic server-side failure (non-success HTTP statuses, invalid payloads, etc).
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Something went wrong on the server']);
}

/// Represents connectivity-related issues.
class NetworkFailure extends Failure {
  const NetworkFailure(
      [super.message = 'Please check your connection and retry']);
}

/// Represents unexpected/uncategorized failures.
class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message = 'Something went wrong']);
}

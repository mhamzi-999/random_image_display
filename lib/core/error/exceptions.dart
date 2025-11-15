/// Thrown when the server returns a non-successful status code or bad payload.
class ServerException implements Exception {
  const ServerException({this.message, this.statusCode});

  final String? message;
  final int? statusCode;
}

/// Thrown when there is no connectivity or the connection is interrupted.
class NetworkException implements Exception {
  const NetworkException([this.message]);

  final String? message;
}

/// Thrown when an unexpected condition occurs while mapping/parsing data.
class UnexpectedException implements Exception {
  const UnexpectedException([this.message]);

  final String? message;
}

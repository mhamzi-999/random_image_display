import 'package:equatable/equatable.dart';

/// Domain entity representing a random image resource from the backend.
class RandomImage extends Equatable {
  const RandomImage({required this.url});

  /// Direct URL pointing to the remote image asset.
  final String url;

  @override
  List<Object?> get props => [url];
}

part of 'random_image_bloc.dart';

/// Base class for all states emitted by [RandomImageBloc].
abstract class RandomImageState extends Equatable {
  const RandomImageState({this.image, this.backgroundColor});

  final RandomImage? image;
  final Color? backgroundColor;

  @override
  List<Object?> get props => [image, backgroundColor];
}

/// Initial idle state before any image has been loaded.
class RandomImageInitial extends RandomImageState {
  const RandomImageInitial({super.backgroundColor});
}

/// Indicates that a new image is currently being fetched.
class RandomImageLoading extends RandomImageState {
  const RandomImageLoading({super.image, super.backgroundColor});
}

/// Represents a successfully loaded image with its accompanying color.
class RandomImageLoaded extends RandomImageState {
  const RandomImageLoaded(
      {required super.image, required super.backgroundColor});
}

/// Captures recoverable failures while keeping the previous image visible.
class RandomImageError extends RandomImageState {
  const RandomImageError(
    this.message, {
    super.image,
    super.backgroundColor,
  });

  final String message;

  @override
  List<Object?> get props => [message, image, backgroundColor];
}

part of 'random_image_bloc.dart';

/// Events that can be triggered on [RandomImageBloc].
abstract class RandomImageEvent extends Equatable {
  const RandomImageEvent();

  @override
  List<Object?> get props => [];
}

/// Requests the bloc to fetch a new random image from the backend.
class RandomImageRequested extends RandomImageEvent {
  const RandomImageRequested();
}

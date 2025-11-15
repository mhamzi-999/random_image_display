import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/random_image.dart';
import '../../domain/usecases/get_random_image.dart';

part 'random_image_event.dart';
part 'random_image_state.dart';

/// Coordinates random image fetching and background color derivation.
class RandomImageBloc extends Bloc<RandomImageEvent, RandomImageState> {
  RandomImageBloc({required GetRandomImage getRandomImage})
      : _getRandomImage = getRandomImage,
        super(const RandomImageInitial()) {
    on<RandomImageRequested>(_onRandomImageRequested);
  }

  final GetRandomImage _getRandomImage;
  static const _fallbackColor = AppColors.surfaceDeep;

  Future<void> _onRandomImageRequested(
    RandomImageRequested event,
    Emitter<RandomImageState> emit,
  ) async {
    emit(
      RandomImageLoading(
        image: state.image,
        backgroundColor: state.backgroundColor ?? _fallbackColor,
      ),
    );

    final result = await _getRandomImage(const NoParams());

    await result.fold(
      (failure) async {
        emit(
          RandomImageError(
            failure.message,
            image: state.image,
            backgroundColor: state.backgroundColor ?? _fallbackColor,
          ),
        );
      },
      (image) async {
        final dominantColor = await _generateDominantColor(image.url);
        emit(RandomImageLoaded(image: image, backgroundColor: dominantColor));
      },
    );
  }

  /// Extracts a dominant color from the provided image URL.
  Future<Color> _generateDominantColor(String url) async {
    try {
      final baseProvider = NetworkImage(url);
      final resizedProvider =
          ResizeImage.resizeIfNeeded(256, null, baseProvider);
      final palette = await PaletteGenerator.fromImageProvider(
        resizedProvider,
        maximumColorCount: 20,
      );
      return palette.dominantColor?.color ??
          palette.vibrantColor?.color ??
          _fallbackColor;
    } catch (_) {
      return _fallbackColor;
    }
  }
}

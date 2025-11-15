import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:aurora_assignment/core/widgets/app_error_message.dart';

import '../bloc/random_image_bloc.dart';
import 'widgets/another_button.dart';
import 'widgets/random_image_background_container.dart';
import 'widgets/random_image_display.dart';

/// Root page that wires together the random image experience.
class RandomImagePage extends StatelessWidget {
  const RandomImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RandomImageBloc, RandomImageState>(
      listener: (context, state) {
        if (state is RandomImageError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
                behavior: SnackBarBehavior.floating,
              ),
            );
        }
      },
      builder: (context, state) {
        final theme = Theme.of(context);
        final backgroundColor =
            state.backgroundColor ?? theme.colorScheme.surface;
        final brightness =
            ThemeData.estimateBrightnessForColor(backgroundColor);
        final foregroundColor =
            brightness == Brightness.dark ? Colors.white : Colors.black87;
        final isLoading = state is RandomImageLoading;
        final imageUrl = state.image?.url;
        final errorMessage = state is RandomImageError ? state.message : null;

        return RandomImageBackgroundContainer(
          color: backgroundColor,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text('Random Image'),
              backgroundColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              foregroundColor: foregroundColor,
              systemOverlayStyle: brightness == Brightness.dark
                  ? SystemUiOverlayStyle.light
                  : SystemUiOverlayStyle.dark,
            ),
            body: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: RandomImageDisplay(
                          imageUrl: imageUrl,
                          isLoading: isLoading,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    AnotherButton(
                      isLoading: isLoading,
                      onPressed: () => context
                          .read<RandomImageBloc>()
                          .add(const RandomImageRequested()),
                    ),
                    const SizedBox(height: 12),
                    AppErrorMessage(
                      message: errorMessage,
                      color: foregroundColor.withValues(alpha: 0.9),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

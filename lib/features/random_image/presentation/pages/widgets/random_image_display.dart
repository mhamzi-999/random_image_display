import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:aurora_assignment/core/widgets/app_loading_indicator.dart';

/// Square display area responsible for rendering the remote image.
class RandomImageDisplay extends StatelessWidget {
  const RandomImageDisplay({
    super.key,
    required this.imageUrl,
    required this.isLoading,
  });

  final String? imageUrl;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final shortestSide = min(constraints.maxWidth, constraints.maxHeight);
        final targetSize = shortestSide.isFinite && shortestSide > 0
            ? shortestSide * 0.7
            : 320.0;

        return Center(
          child: SizedBox(
            width: targetSize,
            height: targetSize,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              child: _buildContent(context, targetSize),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, double size) {
    if (imageUrl != null) {
      return _LoadedImage(url: imageUrl!);
    }

    if (isLoading) {
      return AppLoadingIndicator.shimmer(width: size, height: size);
    }

    return _EmptyState(size: size);
  }
}

class _LoadedImage extends StatelessWidget {
  const _LoadedImage({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      key: ValueKey(url),
      borderRadius: BorderRadius.circular(24),
      child: Semantics(
        label: 'Random image from remote API',
        image: true,
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          fadeInDuration: const Duration(milliseconds: 350),
          placeholder: (context, _) => const AppLoadingIndicator.shimmer(
            width: double.infinity,
            height: double.infinity,
          ),
          errorWidget: (context, _, __) => const _ImageError(),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      key: const ValueKey('empty'),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
        child: Text(
          'Tap “Another” to fetch an image',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }
}

class _ImageError extends StatelessWidget {
  const _ImageError();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.error.withValues(alpha: 0.15),
      alignment: Alignment.center,
      child: Icon(
        Icons.broken_image_outlined,
        color: Theme.of(context).colorScheme.error,
        size: 48,
      ),
    );
  }
}

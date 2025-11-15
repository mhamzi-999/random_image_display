import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Variants supported by [AppLoadingIndicator].
enum AppLoadingIndicatorVariant { spinner, shimmer }

/// Versatile loading indicator that can be reused across the app.
class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator.spinner({
    super.key,
    this.size = 24,
    this.strokeWidth = 2.5,
    this.color,
  })  : variant = AppLoadingIndicatorVariant.spinner,
        width = null,
        height = null,
        borderRadius = null;

  const AppLoadingIndicator.shimmer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 24,
  })  : variant = AppLoadingIndicatorVariant.shimmer,
        size = null,
        strokeWidth = null,
        color = null;

  final AppLoadingIndicatorVariant variant;
  final double? size;
  final double? strokeWidth;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case AppLoadingIndicatorVariant.spinner:
        return SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth ?? 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        );
      case AppLoadingIndicatorVariant.shimmer:
        final onSurface = Theme.of(context).colorScheme.onSurface;
        final baseColor = onSurface.withValues(alpha: 0.12);
        final highlightColor = onSurface.withValues(alpha: 0.3);
        return Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(borderRadius ?? 24),
            ),
          ),
        );
    }
  }
}

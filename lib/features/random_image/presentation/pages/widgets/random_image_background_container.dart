import 'package:flutter/material.dart';

/// Animated container that keeps the random image background in sync with the palette.
class RandomImageBackgroundContainer extends StatelessWidget {
  const RandomImageBackgroundContainer({
    super.key,
    required this.color,
    required this.child,
  });

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      color: color,
      child: child,
    );
  }
}

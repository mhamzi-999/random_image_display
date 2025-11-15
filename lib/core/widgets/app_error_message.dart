import 'package:flutter/material.dart';

/// Displays lightweight inline error feedback.
class AppErrorMessage extends StatelessWidget {
  const AppErrorMessage({super.key, this.message, this.color});

  final String? message;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: message == null
          ? const SizedBox.shrink()
          : Text(
              message!,
              key: const ValueKey('error-message'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: color ??
                      Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.9)),
            ),
    );
  }
}

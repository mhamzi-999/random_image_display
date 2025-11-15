import 'package:flutter/material.dart';

import 'package:aurora_assignment/core/widgets/app_loading_indicator.dart';

/// Primary action button used to request a new random image.
class AnotherButton extends StatelessWidget {
  const AnotherButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: !isLoading,
      label: 'Fetch another random image',
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          child: isLoading
              ? const Row(
                  key: ValueKey('loading'),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppLoadingIndicator.spinner(size: 18, strokeWidth: 2.2),
                    SizedBox(width: 12),
                    Text('Loading…'),
                  ],
                )
              : const Text(
                  'Another',
                  key: ValueKey('another'),
                ),
        ),
      ),
    );
  }
}

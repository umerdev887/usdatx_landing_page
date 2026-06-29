import 'package:flutter/material.dart';

/// A premium gradient accent divider placed between major sections.
/// Uses the primary + secondary accent colors for a subtle glow effect.
class SectionDivider extends StatelessWidget {
  final double maxWidth;
  final double verticalPadding;

  const SectionDivider({
    super.key,
    this.maxWidth = 1200,
    this.verticalPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  theme.colorScheme.primary.withAlpha(isLight ? 60 : 80),
                  theme.colorScheme.secondary.withAlpha(isLight ? 40 : 60),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CapabilityCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtext;
  final String index;
  final bool isVisible;

  const CapabilityCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtext,
    required this.index,
    this.isVisible = false,
  });

  @override
  State<CapabilityCard> createState() => _CapabilityCardState();
}

class _CapabilityCardState extends State<CapabilityCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _revealController;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();
    _revealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _revealController, curve: Curves.easeOutCubic),
    );
    _slideUp = Tween<Offset>(begin: const Offset(0, 40), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _revealController,
            curve: Curves.easeOutCubic,
          ),
        );
  }

  @override
  void didUpdateWidget(CapabilityCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !oldWidget.isVisible) {
      _revealController.forward();
    }
  }

  @override
  void dispose() {
    _revealController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return AnimatedBuilder(
      animation: _revealController,
      builder: (context, child) {
        return Transform.translate(
          offset: _slideUp.value,
          child: Opacity(opacity: _fadeIn.value, child: child),
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 1.0, end: _isHovered ? 1.03 : 1.0),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          builder: (context, scale, child) {
            return Transform.scale(scale: scale, child: child);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: isLight ? Colors.white : theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _isHovered
                    ? theme.colorScheme.primary.withAlpha(isLight ? 180 : 150)
                    : theme.colorScheme.outline.withAlpha(isLight ? 100 : 60),
                width: 1.5,
              ),
              boxShadow: [
                if (_isHovered)
                  BoxShadow(
                    color: theme.colorScheme.primary
                        .withAlpha(isLight ? 30 : 25),
                    blurRadius: 40,
                    offset: const Offset(0, 15),
                  )
                else
                  BoxShadow(
                    color: Colors.black.withAlpha(isLight ? 18 : 40),
                    blurRadius: isLight ? 24 : 20,
                    offset: const Offset(0, 8),
                  ),
                if (isLight && !_isHovered)
                  BoxShadow(
                    color: theme.colorScheme.primary.withAlpha(8),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Index + Icon row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Index badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: theme.colorScheme.primary
                            .withAlpha(isLight ? 18 : 15),
                        border: Border.all(
                          color: theme.colorScheme.primary
                              .withAlpha(isLight ? 60 : 40),
                        ),
                      ),
                      child: Text(
                        widget.index,
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    // Icon
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: _isHovered
                            ? theme.colorScheme.primary
                                .withAlpha(isLight ? 30 : 25)
                            : theme.colorScheme.primary
                                .withAlpha(isLight ? 15 : 10),
                      ),
                      child: Icon(
                        widget.icon,
                        size: 28,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Title
                Text(
                  widget.title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontSize: 21,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 14),

                // Subtext
                Text(
                  widget.subtext,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.7,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 24),

                // Telemetry bars + Learn more
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Telemetry vector bars
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(5, (i) {
                        final heights = [16.0, 28.0, 12.0, 36.0, 20.0];
                        final opacities = [0.25, 0.5, 0.2, 0.8, 0.35];
                        return Padding(
                          padding: EdgeInsets.only(right: i < 4 ? 4 : 0),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 400 + i * 100),
                            width: 4,
                            height: _isHovered ? heights[i] * 1.2 : heights[i],
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: theme.colorScheme.primary.withAlpha(
                                (opacities[i] * 255).toInt(),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    // Learn more link
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        color: _isHovered
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurfaceVariant,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Learn more'),
                          const SizedBox(width: 4),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            transform: Matrix4.translationValues(
                              _isHovered ? 4 : 0,
                              0,
                              0,
                            ),
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              size: 16,
                              color: _isHovered
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

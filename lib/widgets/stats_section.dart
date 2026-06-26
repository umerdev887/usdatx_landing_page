import 'package:flutter/material.dart';

import '../responsive_layout.dart';

class StatsSection extends StatefulWidget {
  final bool isVisible;

  const StatsSection({super.key, this.isVisible = false});

  @override
  State<StatsSection> createState() => _StatsSectionState();
}

class _StatsSectionState extends State<StatsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _counterProgress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _counterProgress = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void didUpdateWidget(StatsSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !oldWidget.isVisible) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: isMobile ? 24 : 48,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        // Subtle radial gradient
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.2,
          colors: [
            theme.colorScheme.primary.withAlpha(8),
            theme.colorScheme.surface,
          ],
        ),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: Center(
          child: AnimatedBuilder(
            animation: _counterProgress,
            builder: (context, child) {
              return Wrap(
                spacing: isMobile ? 16 : 48,
                runSpacing: 32,
                alignment: WrapAlignment.center,
                children: [
                  _buildStatItem(
                    theme,
                    _animateValue(10, _counterProgress.value),
                    '+',
                    'Projects\nDeployed',
                    Icons.rocket_launch_outlined,
                    isMobile,
                  ),
                  _buildDivider(theme, isMobile),
                  _buildStatItem(
                    theme,
                    _animateValue(5, _counterProgress.value),
                    '+',
                    'Industries\nServed',
                    Icons.business_outlined,
                    isMobile,
                  ),
                  _buildDivider(theme, isMobile),
                  _buildStatItem(
                    theme,
                    _animateDecimal(99.9, _counterProgress.value),
                    '%',
                    'System\nUptime',
                    Icons.speed_outlined,
                    isMobile,
                  ),
                  _buildDivider(theme, isMobile),
                  _buildStatItem(
                    theme,
                    '24/7',
                    '',
                    'Support\nAvailable',
                    Icons.support_agent_outlined,
                    isMobile,
                    isText: true,
                    textOpacity: _counterProgress.value,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  String _animateValue(int target, double progress) {
    return (target * progress).round().toString();
  }

  String _animateDecimal(double target, double progress) {
    final value = target * progress;
    return value.toStringAsFixed(1);
  }

  Widget _buildStatItem(
    ThemeData theme,
    String value,
    String suffix,
    String label,
    IconData icon,
    bool isMobile, {
    bool isText = false,
    double textOpacity = 1.0,
  }) {
    final displayValue = isText ? value : value;
    final opacity = isText ? textOpacity : 1.0;

    return SizedBox(
      width: isMobile ? 140 : 180,
      child: Opacity(
        opacity: opacity.clamp(0.0, 1.0),
        child: Column(
          children: [
            Icon(
              icon,
              size: 28,
              color: theme.colorScheme.primary.withAlpha(120),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  displayValue,
                  style: TextStyle(
                    fontSize: isMobile ? 36 : 48,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                    height: 1,
                  ),
                ),
                if (suffix.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      suffix,
                      style: TextStyle(
                        fontSize: isMobile ? 20 : 28,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(ThemeData theme, bool isMobile) {
    if (isMobile) return const SizedBox.shrink();
    return Container(
      width: 1,
      height: 80,
      color: theme.colorScheme.outline.withAlpha(40),
    );
  }
}

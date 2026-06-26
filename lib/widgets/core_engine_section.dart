import 'package:flutter/material.dart';

import '../responsive_layout.dart';

class CoreEngineSection extends StatefulWidget {
  final bool isVisible;

  const CoreEngineSection({super.key, this.isVisible = false});

  @override
  State<CoreEngineSection> createState() => _CoreEngineSectionState();
}

class _CoreEngineSectionState extends State<CoreEngineSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeIn = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 50),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void didUpdateWidget(CoreEngineSection oldWidget) {
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

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: _slideUp.value,
          child: Opacity(opacity: _fadeIn.value, child: child),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 100,
          horizontal: isMobile ? 24 : 48,
        ),
        decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
        child: Column(
          children: [
            // Section header
            _buildSectionLabel(theme, 'ARCHITECTURE'),
            const SizedBox(height: 16),
            Text(
              'CORE ENGINE',
              style: theme.textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                'One Codebase. Absolute Coverage. Built entirely on Flutter Web & Mobile frameworks for synchronized execution.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 80),

            // Device mockups
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: isMobile
                  ? Column(
                      children: [
                        _buildPhoneMockup(theme),
                        const SizedBox(height: 48),
                        _buildDesktopMockup(theme, isMobile),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildPhoneMockup(theme),
                        const SizedBox(width: 64),
                        Flexible(child: _buildDesktopMockup(theme, isMobile)),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(ThemeData theme, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: theme.colorScheme.primary.withAlpha(40)),
        color: theme.colorScheme.primary.withAlpha(10),
      ),
      child: Text(
        text,
        style: theme.textTheme.labelMedium?.copyWith(
          fontSize: 12,
          letterSpacing: 2,
        ),
      ),
    );
  }

  Widget _buildPhoneMockup(ThemeData theme) {
    return Column(
      children: [
        Container(
          width: 260,
          height: 530,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(36),
            border: Border.all(
              color: theme.colorScheme.outline.withAlpha(80),
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withAlpha(15),
                blurRadius: 40,
                offset: const Offset(-15, 15),
              ),
              BoxShadow(
                color: Colors.black.withAlpha(60),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              // Status bar
              const SizedBox(height: 12),
              // Notch
              Container(
                width: 100,
                height: 28,
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              const SizedBox(height: 16),
              // App content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header bar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 80,
                            height: 10,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.onSurface.withAlpha(40),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          Icon(
                            Icons.notifications_none_rounded,
                            size: 18,
                            color: theme.colorScheme.primary.withAlpha(120),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Metric cards
                      Row(
                        children: [
                          Expanded(
                            child: _buildMiniMetricCard(
                              theme,
                              'Active',
                              '24',
                              const Color(0xFF00FF88),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildMiniMetricCard(
                              theme,
                              'Pending',
                              '7',
                              theme.colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // List items
                      ...List.generate(4, (i) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceContainerHighest
                                  .withAlpha(120),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary.withAlpha(
                                      20 + i * 10,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    [
                                      Icons.local_shipping_outlined,
                                      Icons.inventory_2_outlined,
                                      Icons.analytics_outlined,
                                      Icons.check_circle_outline,
                                    ][i],
                                    size: 16,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 80 + i * 10.0,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.onSurface
                                              .withAlpha(30),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        width: 50,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.onSurface
                                              .withAlpha(15),
                                          borderRadius: BorderRadius.circular(
                                            3,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              // Bottom nav
              Container(
                height: 56,
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.home_rounded,
                      size: 22,
                      color: theme.colorScheme.primary,
                    ),
                    Icon(
                      Icons.search_rounded,
                      size: 22,
                      color: theme.colorScheme.onSurface.withAlpha(60),
                    ),
                    Icon(
                      Icons.add_circle_outline_rounded,
                      size: 22,
                      color: theme.colorScheme.onSurface.withAlpha(60),
                    ),
                    Icon(
                      Icons.person_outline_rounded,
                      size: 22,
                      color: theme.colorScheme.onSurface.withAlpha(60),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Mobile App',
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildMiniMetricCard(
    ThemeData theme,
    String label,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: theme.colorScheme.onSurface.withAlpha(100),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopMockup(ThemeData theme, bool isMobile) {
    return Column(
      children: [
        Container(
          width: isMobile ? double.infinity : 620,
          height: isMobile ? 320 : 420,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: theme.colorScheme.outline.withAlpha(80),
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withAlpha(15),
                blurRadius: 40,
                offset: const Offset(15, 15),
              ),
              BoxShadow(
                color: Colors.black.withAlpha(60),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              // Title bar
              Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                ),
                child: Row(
                  children: [
                    _buildWindowDot(Colors.redAccent.withAlpha(200)),
                    const SizedBox(width: 8),
                    _buildWindowDot(Colors.orangeAccent.withAlpha(200)),
                    const SizedBox(width: 8),
                    _buildWindowDot(Colors.greenAccent.withAlpha(200)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        height: 22,
                        decoration: BoxDecoration(
                          color: theme.scaffoldBackgroundColor.withAlpha(100),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            'dashboard.ustadx.com',
                            style: TextStyle(
                              fontSize: 10,
                              color: theme.colorScheme.onSurface.withAlpha(60),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
              // Dashboard content
              Expanded(
                child: Row(
                  children: [
                    // Sidebar
                    Container(
                      width: isMobile ? 44 : 56,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest
                            .withAlpha(80),
                        border: Border(
                          right: BorderSide(
                            color: theme.colorScheme.outline.withAlpha(30),
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          ...List.generate(5, (i) {
                            final isActive = i == 0;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 8,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: isActive
                                      ? theme.colorScheme.primary.withAlpha(20)
                                      : Colors.transparent,
                                ),
                                child: Icon(
                                  [
                                    Icons.dashboard_rounded,
                                    Icons.analytics_outlined,
                                    Icons.inventory_2_outlined,
                                    Icons.people_outline_rounded,
                                    Icons.settings_outlined,
                                  ][i],
                                  size: isMobile ? 16 : 20,
                                  color: isActive
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.onSurface.withAlpha(
                                          50,
                                        ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    // Main area
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(isMobile ? 12 : 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Top metrics row
                            Row(
                              children: [
                                Expanded(
                                  child: _buildDashboardMetric(
                                    theme,
                                    'Revenue',
                                    '₹4.2M',
                                    '+12%',
                                    true,
                                    isMobile,
                                  ),
                                ),
                                SizedBox(width: isMobile ? 6 : 12),
                                Expanded(
                                  child: _buildDashboardMetric(
                                    theme,
                                    'Orders',
                                    '1,284',
                                    '+8%',
                                    true,
                                    isMobile,
                                  ),
                                ),
                                SizedBox(width: isMobile ? 6 : 12),
                                Expanded(
                                  child: _buildDashboardMetric(
                                    theme,
                                    'Uptime',
                                    '99.9%',
                                    '',
                                    false,
                                    isMobile,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: isMobile ? 10 : 16),
                            // Chart placeholder
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: theme
                                      .colorScheme
                                      .surfaceContainerHighest
                                      .withAlpha(80),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: theme.colorScheme.outline.withAlpha(
                                      30,
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.all(isMobile ? 10 : 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Operations Overview',
                                      style: TextStyle(
                                        fontSize: isMobile ? 10 : 13,
                                        fontWeight: FontWeight.w600,
                                        color: theme.colorScheme.onSurface
                                            .withAlpha(120),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    // Fake chart bars
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: List.generate(12, (i) {
                                          final heights = [
                                            0.4,
                                            0.6,
                                            0.3,
                                            0.8,
                                            0.5,
                                            0.7,
                                            0.9,
                                            0.6,
                                            0.75,
                                            0.85,
                                            0.65,
                                            0.95,
                                          ];
                                          return Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 2,
                                                  ),
                                              child: FractionallySizedBox(
                                                heightFactor: heights[i],
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          3,
                                                        ),
                                                    gradient: LinearGradient(
                                                      begin: Alignment
                                                          .bottomCenter,
                                                      end: Alignment.topCenter,
                                                      colors: [
                                                        theme
                                                            .colorScheme
                                                            .primary
                                                            .withAlpha(40),
                                                        theme
                                                            .colorScheme
                                                            .primary
                                                            .withAlpha(140),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Web Dashboard',
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildWindowDot(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildDashboardMetric(
    ThemeData theme,
    String label,
    String value,
    String change,
    bool positive,
    bool isMobile,
  ) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 8 : 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withAlpha(80),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.colorScheme.outline.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isMobile ? 9 : 11,
              color: theme.colorScheme.onSurface.withAlpha(80),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Flexible(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 18,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (change.isNotEmpty) ...[
                const SizedBox(width: 4),
                Text(
                  change,
                  style: TextStyle(
                    fontSize: isMobile ? 8 : 10,
                    fontWeight: FontWeight.w600,
                    color: positive
                        ? const Color(0xFF00FF88)
                        : Colors.redAccent,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

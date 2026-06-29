import 'package:flutter/material.dart';

import '../responsive_layout.dart';

class WhyChooseUsSection extends StatefulWidget {
  final bool isVisible;

  const WhyChooseUsSection({super.key, this.isVisible = false});

  @override
  State<WhyChooseUsSection> createState() => _WhyChooseUsSectionState();
}

class _WhyChooseUsSectionState extends State<WhyChooseUsSection>
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
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _slideUp =
        Tween<Offset>(begin: const Offset(0, 40), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void didUpdateWidget(WhyChooseUsSection oldWidget) {
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
    final isLight = theme.brightness == Brightness.light;

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
        decoration: BoxDecoration(
          color: isLight
              ? const Color(0xFFF1F5F9)
              : theme.scaffoldBackgroundColor,
        ),
        child: Column(
          children: [
            // Section label
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: theme.colorScheme.primary.withAlpha(40),
                ),
                color: theme.colorScheme.primary.withAlpha(10),
              ),
              child: Text(
                'WHY US',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontSize: 12,
                  letterSpacing: 2,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'WHY CHOOSE USTADX',
              style: theme.textTheme.headlineLarge?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                'We don\'t just build software — we engineer competitive advantages that transform how your business operates.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: 72),

            // Reasons grid
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final cardWidth = isMobile
                      ? constraints.maxWidth
                      : (constraints.maxWidth - 24) / 2;

                  return Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    alignment: WrapAlignment.center,
                    children: [
                      SizedBox(
                        width: cardWidth,
                        child: _ReasonCard(
                          icon: Icons.code_rounded,
                          accentColor: const Color(0xFF00E5FF),
                          title: 'Single Codebase, All Platforms',
                          description:
                              'We build with Flutter — one codebase that deploys to Android, iOS, Web, and Desktop simultaneously. No duplicated effort, no platform inconsistencies, just unified performance.',
                          index: '01',
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: _ReasonCard(
                          icon: Icons.speed_rounded,
                          accentColor: const Color(0xFF00FF88),
                          title: 'Rapid Delivery, Zero Compromise',
                          description:
                              'Our agile process delivers production-ready MVPs in weeks, not months. We iterate fast, ship faster, and maintain the engineering rigor that enterprise clients demand.',
                          index: '02',
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: _ReasonCard(
                          icon: Icons.architecture_rounded,
                          accentColor: const Color(0xFFFFB800),
                          title: 'Battle-Tested Architecture',
                          description:
                              'Every system we build follows proven architectural patterns — clean architecture, modular design, and scalable infrastructure that grows with your business without technical debt.',
                          index: '03',
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: _ReasonCard(
                          icon: Icons.support_agent_rounded,
                          accentColor: const Color(0xFFB388FF),
                          title: 'End-to-End Ownership',
                          description:
                              'From initial discovery to deployment and ongoing maintenance, we own the entire lifecycle. Your systems never go unmonitored and your team is never left without support.',
                          index: '04',
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 80),
            
            // Tech Stack Badges
            Text(
              'ENGINEERED WITH',
              style: theme.textTheme.labelMedium?.copyWith(
                fontSize: 12,
                letterSpacing: 2,
                color: theme.colorScheme.onSurfaceVariant.withAlpha(150),
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                _buildTechBadge(theme, 'Flutter', Icons.flutter_dash_rounded),
                _buildTechBadge(theme, 'Dart', Icons.code_rounded),
                _buildTechBadge(theme, 'Firebase', Icons.local_fire_department_rounded),
                _buildTechBadge(theme, 'Node.js', Icons.javascript_rounded),
                _buildTechBadge(theme, 'PostgreSQL', Icons.storage_rounded),
                _buildTechBadge(theme, 'AWS', Icons.cloud_rounded),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechBadge(ThemeData theme, String name, IconData icon) {
    final isLight = theme.brightness == Brightness.light;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isLight ? Colors.white : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: theme.colorScheme.outline.withAlpha(isLight ? 80 : 50),
        ),
        boxShadow: isLight
            ? [
                BoxShadow(
                  color: Colors.black.withAlpha(8),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Text(
            name,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReasonCard extends StatefulWidget {
  final IconData icon;
  final Color accentColor;
  final String title;
  final String description;
  final String index;

  const _ReasonCard({
    required this.icon,
    required this.accentColor,
    required this.title,
    required this.description,
    required this.index,
  });

  @override
  State<_ReasonCard> createState() => _ReasonCardState();
}

class _ReasonCardState extends State<_ReasonCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: isLight ? Colors.white : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? widget.accentColor.withAlpha(isLight ? 160 : 120)
                : theme.colorScheme.outline.withAlpha(isLight ? 80 : 40),
            width: 1.5,
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: widget.accentColor.withAlpha(isLight ? 25 : 20),
                blurRadius: 40,
                offset: const Offset(0, 12),
              )
            else
              BoxShadow(
                color: Colors.black.withAlpha(isLight ? 15 : 20),
                blurRadius: isLight ? 24 : 20,
                offset: const Offset(0, 6),
              ),
            if (isLight && !_isHovered)
              BoxShadow(
                color: widget.accentColor.withAlpha(6),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left accent stripe + icon
            Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: widget.accentColor.withAlpha(_isHovered ? 30 : 15),
                    border: Border.all(
                      color: widget.accentColor.withAlpha(_isHovered ? 60 : 30),
                    ),
                  ),
                  child: Icon(
                    widget.icon,
                    size: 26,
                    color: widget.accentColor,
                  ),
                ),
                const SizedBox(height: 12),
                // Vertical accent bar
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: 2,
                  height: _isHovered ? 40 : 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        widget.accentColor.withAlpha(120),
                        widget.accentColor.withAlpha(0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 24),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Index
                  Text(
                    widget.index,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: widget.accentColor.withAlpha(120),
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Title
                  Text(
                    widget.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Description
                  Text(
                    widget.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.7,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

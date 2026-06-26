import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../responsive_layout.dart';

class ProjectsSection extends StatefulWidget {
  final bool isVisible;

  const ProjectsSection({super.key, this.isVisible = false});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection>
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
  void didUpdateWidget(ProjectsSection oldWidget) {
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
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
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
                'PORTFOLIO',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontSize: 12,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'PROJECTS WE\'VE BUILT',
              style: theme.textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                'From global hiring platforms to fintech solutions — here\'s a glimpse of the systems we\'ve engineered.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 72),

            // Projects grid
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
                        child: const _ProjectCard(
                          title: 'SuperSourcing',
                          url: 'https://supersourcing.com',
                          domain: 'supersourcing.com',
                          category: 'Hiring Platform',
                          description:
                              'A global tech talent hiring platform connecting companies with pre-vetted remote developers. Features AI-powered matching, real-time collaboration tools, and enterprise-grade talent pipelines.',
                          gradient: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                          icon: Icons.groups_rounded,
                          stats: ['500K+ Developers', 'Global Reach'],
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: const _ProjectCard(
                          title: 'Hirium',
                          url: 'https://hirium.com',
                          domain: 'hirium.com',
                          category: 'ATS & Recruitment',
                          description:
                              'An intelligent Applicant Tracking System that streamlines the entire recruitment pipeline. Automated resume parsing, interview scheduling, candidate scoring, and analytics dashboards built for modern HR teams.',
                          gradient: [Color(0xFF06B6D4), Color(0xFF0891B2)],
                          icon: Icons.work_outline_rounded,
                          stats: ['Smart ATS', 'AI-Powered'],
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: const _ProjectCard(
                          title: 'Kifayat Card',
                          url: null,
                          domain: 'Fintech Solution',
                          category: 'Fintech & Payments',
                          description:
                              'A digital discount card ecosystem enabling consumers to access exclusive deals across partner merchants. Features QR-based payments, loyalty rewards tracking, merchant analytics, and real-time transaction processing.',
                          gradient: [Color(0xFFFFB800), Color(0xFFFF8C00)],
                          icon: Icons.credit_card_rounded,
                          stats: ['Digital Payments', 'Loyalty System'],
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: const _ProjectCard(
                          title: 'Fab Learner',
                          url: null,
                          domain: 'EdTech Platform',
                          category: 'Education & E-Learning',
                          description:
                              'A comprehensive e-learning platform with interactive courses, progress tracking, and gamified learning paths. Features video streaming, quizzes, certificates, and student-instructor communication tools.',
                          gradient: [Color(0xFF10B981), Color(0xFF059669)],
                          icon: Icons.school_rounded,
                          stats: ['Interactive Learning', 'Gamified'],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final String title;
  final String? url;
  final String domain;
  final String category;
  final String description;
  final List<Color> gradient;
  final IconData icon;
  final List<String> stats;

  const _ProjectCard({
    required this.title,
    required this.url,
    required this.domain,
    required this.category,
    required this.description,
    required this.gradient,
    required this.icon,
    required this.stats,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      cursor: widget.url != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.url != null
            ? () async {
                final uri = Uri.parse(widget.url!);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              }
            : null,
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 1.0, end: _isHovered ? 1.02 : 1.0),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          builder: (context, scale, child) =>
              Transform.scale(scale: scale, child: child),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: _isHovered
                    ? widget.gradient[0].withAlpha(100)
                    : theme.colorScheme.outline.withAlpha(40),
                width: 1.5,
              ),
              boxShadow: [
                if (_isHovered)
                  BoxShadow(
                    color: widget.gradient[0].withAlpha(25),
                    blurRadius: 50,
                    offset: const Offset(0, 15),
                  )
                else
                  BoxShadow(
                    color: Colors.black.withAlpha(25),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with gradient
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(23)),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        widget.gradient[0].withAlpha(25),
                        widget.gradient[1].withAlpha(10),
                      ],
                    ),
                    border: Border(
                      bottom: BorderSide(
                        color: widget.gradient[0].withAlpha(20),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Project icon
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: widget.gradient,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: widget.gradient[0].withAlpha(60),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Icon(
                          widget.icon,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 18),
                      // Title and category
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.category,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: widget.gradient[0],
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // External link indicator
                      if (widget.url != null)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          transform: Matrix4.translationValues(
                            _isHovered ? 2 : 0,
                            _isHovered ? -2 : 0,
                            0,
                          ),
                          child: Icon(
                            Icons.open_in_new_rounded,
                            size: 20,
                            color: _isHovered
                                ? widget.gradient[0]
                                : theme.colorScheme.onSurfaceVariant
                                    .withAlpha(80),
                          ),
                        ),
                    ],
                  ),
                ),
                // Body
                Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Domain / URL
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: widget.gradient[0].withAlpha(10),
                          border: Border.all(
                            color: widget.gradient[0].withAlpha(30),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              widget.url != null
                                  ? Icons.language_rounded
                                  : Icons.smartphone_rounded,
                              size: 14,
                              color: widget.gradient[0].withAlpha(180),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              widget.domain,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: widget.gradient[0].withAlpha(200),
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      // Description
                      Text(
                        widget.description,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.7,
                        ),
                      ),
                      const SizedBox(height: 22),
                      // Stats chips
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.stats.map((stat) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color:
                                  theme.colorScheme.surfaceContainerHighest,
                              border: Border.all(
                                color:
                                    theme.colorScheme.outline.withAlpha(30),
                              ),
                            ),
                            child: Text(
                              stat,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.onSurface
                                    .withAlpha(160),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../responsive_layout.dart';

class ProcessSection extends StatefulWidget {
  final bool isVisible;

  const ProcessSection({super.key, this.isVisible = false});

  @override
  State<ProcessSection> createState() => _ProcessSectionState();
}

class _ProcessSectionState extends State<ProcessSection>
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
  void didUpdateWidget(ProcessSection oldWidget) {
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
          color: theme.scaffoldBackgroundColor,
        ),
        child: Column(
          children: [
            // Section label
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: theme.colorScheme.primary.withAlpha(40),
                ),
                color: theme.colorScheme.primary.withAlpha(10),
              ),
              child: Text(
                'OUR PROCESS',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontSize: 12,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'HOW WE WORK',
              style: theme.textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                'A streamlined, transparent engineering process designed to take your idea from concept to production-ready system.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 72),

            // Process steps
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: isMobile
                  ? _buildMobileProcess(theme)
                  : _buildDesktopProcess(theme),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopProcess(ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _ProcessStep(
            number: '01',
            title: 'Discovery',
            description:
                'We learn your business, identify pain points, and define the system requirements and technical scope.',
            icon: Icons.search_rounded,
            theme: theme,
          ),
        ),
        _buildConnector(theme),
        Expanded(
          child: _ProcessStep(
            number: '02',
            title: 'Architecture',
            description:
                'We create UI/UX wireframes, design the system architecture, and finalize the technology stack.',
            icon: Icons.architecture_rounded,
            theme: theme,
          ),
        ),
        _buildConnector(theme),
        Expanded(
          child: _ProcessStep(
            number: '03',
            title: 'Development',
            description:
                'Agile engineering sprints with weekly demos, ensuring constant feedback and transparent progress.',
            icon: Icons.code_rounded,
            theme: theme,
          ),
        ),
        _buildConnector(theme),
        Expanded(
          child: _ProcessStep(
            number: '04',
            title: 'Launch',
            description:
                'Rigorous QA testing, seamless production deployment, and ongoing technical support and maintenance.',
            icon: Icons.rocket_launch_rounded,
            theme: theme,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileProcess(ThemeData theme) {
    return Column(
      children: [
        _ProcessStep(
          number: '01',
          title: 'Discovery',
          description:
              'We learn your business, identify pain points, and define the system requirements and technical scope.',
          icon: Icons.search_rounded,
          theme: theme,
          isMobile: true,
        ),
        _buildVerticalConnector(theme),
        _ProcessStep(
          number: '02',
          title: 'Architecture',
          description:
              'We create UI/UX wireframes, design the system architecture, and finalize the technology stack.',
          icon: Icons.architecture_rounded,
          theme: theme,
          isMobile: true,
        ),
        _buildVerticalConnector(theme),
        _ProcessStep(
          number: '03',
          title: 'Development',
          description:
              'Agile engineering sprints with weekly demos, ensuring constant feedback and transparent progress.',
          icon: Icons.code_rounded,
          theme: theme,
          isMobile: true,
        ),
        _buildVerticalConnector(theme),
        _ProcessStep(
          number: '04',
          title: 'Launch',
          description:
              'Rigorous QA testing, seamless production deployment, and ongoing technical support and maintenance.',
          icon: Icons.rocket_launch_rounded,
          theme: theme,
          isMobile: true,
        ),
      ],
    );
  }

  Widget _buildConnector(ThemeData theme) {
    return Container(
      width: 40,
      height: 2,
      margin: const EdgeInsets.only(top: 36),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withAlpha(40),
      ),
    );
  }

  Widget _buildVerticalConnector(ThemeData theme) {
    return Container(
      width: 2,
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withAlpha(40),
      ),
    );
  }
}

class _ProcessStep extends StatefulWidget {
  final String number;
  final String title;
  final String description;
  final IconData icon;
  final ThemeData theme;
  final bool isMobile;

  const _ProcessStep({
    required this.number,
    required this.title,
    required this.description,
    required this.icon,
    required this.theme,
    this.isMobile = false,
  });

  @override
  State<_ProcessStep> createState() => _ProcessStepState();
}

class _ProcessStepState extends State<_ProcessStep> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: widget.isMobile
          ? _buildMobileLayout()
          : _buildDesktopLayout(),
    );
  }

  Widget _buildDesktopLayout() {
    return Column(
      children: [
        // Icon Circle
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.theme.colorScheme.surface,
            border: Border.all(
              color: _isHovered
                  ? widget.theme.colorScheme.primary.withAlpha(150)
                  : widget.theme.colorScheme.primary.withAlpha(40),
              width: 2,
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: widget.theme.colorScheme.primary.withAlpha(40),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: Center(
            child: Icon(
              widget.icon,
              size: 28,
              color: _isHovered
                  ? widget.theme.colorScheme.primary
                  : widget.theme.colorScheme.primary.withAlpha(180),
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Step Number
        Text(
          'STEP ${widget.number}',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: widget.theme.colorScheme.primary,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        // Title
        Text(
          widget.title,
          textAlign: TextAlign.center,
          style: widget.theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        // Description
        Text(
          widget.description,
          textAlign: TextAlign.center,
          style: widget.theme.textTheme.bodySmall?.copyWith(
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon Circle
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.theme.colorScheme.surface,
            border: Border.all(
              color: _isHovered
                  ? widget.theme.colorScheme.primary.withAlpha(150)
                  : widget.theme.colorScheme.primary.withAlpha(40),
              width: 2,
            ),
          ),
          child: Center(
            child: Icon(
              widget.icon,
              size: 24,
              color: _isHovered
                  ? widget.theme.colorScheme.primary
                  : widget.theme.colorScheme.primary.withAlpha(180),
            ),
          ),
        ),
        const SizedBox(width: 24),
        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'STEP ${widget.number}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: widget.theme.colorScheme.primary,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.title,
                style: widget.theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.description,
                style: widget.theme.textTheme.bodySmall?.copyWith(
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../responsive_layout.dart';
import 'tech_grid.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onRequestDiscovery;

  const HeroSection({super.key, required this.onRequestDiscovery});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late AnimationController _shimmerController;
  late Animation<double> _headlineOpacity;
  late Animation<Offset> _headlineSlide;
  late Animation<double> _subheadOpacity;
  late Animation<Offset> _subheadSlide;
  late Animation<double> _badgeOpacity;
  late Animation<double> _ctaOpacity;
  late Animation<Offset> _ctaSlide;

  bool _isCtaHovered = false;
  bool _hasMouse = false;
  Offset _mousePosition = Offset.zero;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();

    // Staggered entrance animations
    _badgeOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOutCubic),
      ),
    );

    _headlineOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.1, 0.5, curve: Curves.easeOutCubic),
      ),
    );

    _headlineSlide =
        Tween<Offset>(begin: const Offset(0, 40), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.1, 0.5, curve: Curves.easeOutCubic),
      ),
    );

    _subheadOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.25, 0.65, curve: Curves.easeOutCubic),
      ),
    );

    _subheadSlide =
        Tween<Offset>(begin: const Offset(0, 30), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.25, 0.65, curve: Curves.easeOutCubic),
      ),
    );

    _ctaOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.45, 0.85, curve: Curves.easeOutCubic),
      ),
    );

    _ctaSlide =
        Tween<Offset>(begin: const Offset(0, 20), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.45, 0.85, curve: Curves.easeOutCubic),
      ),
    );

    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.stop();
    _shimmerController.stop();
    _entranceController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final currentMouseX = _hasMouse ? _mousePosition.dx : centerX;
    final currentMouseY = _hasMouse ? _mousePosition.dy : centerY;

    final parallaxX = ((currentMouseX - centerX) / centerX).clamp(-1.0, 1.0);
    final parallaxY = ((currentMouseY - centerY) / centerY).clamp(-1.0, 1.0);

    return MouseRegion(
      onHover: (event) {
        setState(() {
          _hasMouse = true;
          _mousePosition = event.position;
        });
      },
      onExit: (_) => setState(() => _hasMouse = false),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: size.height * 0.92,
        ),
        child: TweenAnimationBuilder<Offset>(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          tween: Tween<Offset>(
            begin: Offset.zero,
            end: Offset(parallaxX, parallaxY),
          ),
          builder: (context, offset, child) {
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0008)
                ..rotateX(-offset.dy * 0.02)
                ..rotateY(offset.dx * 0.02),
              alignment: FractionalOffset.center,
              child: child,
            );
          },
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1300),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 48,
                  vertical: 48,
                ),
                child: isMobile
                    ? _buildMobileLayout(theme, isMobile)
                    : _buildDesktopLayout(theme, isMobile),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(ThemeData theme, bool isMobile) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 3, child: _buildLeftColumn(theme, isMobile)),
        const SizedBox(width: 48),
        Expanded(
          flex: 2,
          child: TechGrid(
            width: 400,
            height: 400,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(ThemeData theme, bool isMobile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLeftColumn(theme, isMobile),
      ],
    );
  }

  Widget _buildLeftColumn(ThemeData theme, bool isMobile) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Floating badge
        AnimatedBuilder(
          animation: _entranceController,
          builder: (context, child) {
            return Opacity(opacity: _badgeOpacity.value, child: child);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: theme.colorScheme.primary.withAlpha(60),
              ),
              color: theme.colorScheme.primary.withAlpha(15),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF00FF88),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00FF88).withAlpha(150),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Trusted by Clients Across 5+ Industries',
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontSize: 13,
                    color: theme.colorScheme.onSurface.withAlpha(180),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),

        // Headline with shimmer
        AnimatedBuilder(
          animation: _entranceController,
          builder: (context, child) {
            return Transform.translate(
              offset: _headlineSlide.value,
              child: Opacity(opacity: _headlineOpacity.value, child: child),
            );
          },
          child: _buildShimmerHeadline(theme, isMobile),
        ),
        const SizedBox(height: 28),

        // Subheadline
        AnimatedBuilder(
          animation: _entranceController,
          builder: (context, child) {
            return Transform.translate(
              offset: _subheadSlide.value,
              child: Opacity(opacity: _subheadOpacity.value, child: child),
            );
          },
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              'We\'re a software agency that builds cross-platform apps, enterprise dashboards, and digital products — from idea to launch.',
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
              style: theme.textTheme.bodyLarge,
            ),
          ),
        ),
        const SizedBox(height: 48),

        // CTA Button
        AnimatedBuilder(
          animation: _entranceController,
          builder: (context, child) {
            return Transform.translate(
              offset: _ctaSlide.value,
              child: Opacity(opacity: _ctaOpacity.value, child: child),
            );
          },
          child: _buildCtaButton(theme),
        ),
      ],
    );
  }

  Widget _buildShimmerHeadline(ThemeData theme, bool isMobile) {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            final shimmerPosition = _shimmerController.value * 3 - 1;
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.onSurface,
                theme.colorScheme.primary,
                theme.colorScheme.onSurface,
              ],
              stops: [
                (shimmerPosition - 0.3).clamp(0.0, 1.0),
                shimmerPosition.clamp(0.0, 1.0),
                (shimmerPosition + 0.3).clamp(0.0, 1.0),
              ],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: Text(
        'WE ENGINEER APPS\nTHAT SCALE\nYOUR BUSINESS',
        textAlign: isMobile ? TextAlign.center : TextAlign.left,
        style: (isMobile
                ? theme.textTheme.displaySmall
                : theme.textTheme.displayMedium)
            ?.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCtaButton(ThemeData theme) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isCtaHovered = true),
      onExit: (_) => setState(() => _isCtaHovered = false),
      child: GestureDetector(
        onTap: widget.onRequestDiscovery,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: _isCtaHovered
                ? null
                : LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.primary.withAlpha(200),
                    ],
                  ),
            color: _isCtaHovered ? Colors.transparent : null,
            border: Border.all(
              color: theme.colorScheme.primary,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary
                    .withAlpha(_isCtaHovered ? 100 : 50),
                blurRadius: _isCtaHovered ? 30 : 15,
                spreadRadius: _isCtaHovered ? 2 : 0,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: _isCtaHovered
                      ? theme.colorScheme.primary
                      : theme.scaffoldBackgroundColor,
                ),
                child: const Text('Let\'s Discuss Your Project'),
              ),
              const SizedBox(width: 12),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                transform: Matrix4.translationValues(
                  _isCtaHovered ? 4 : 0,
                  0,
                  0,
                ),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 20,
                  color: _isCtaHovered
                      ? theme.colorScheme.primary
                      : theme.scaffoldBackgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

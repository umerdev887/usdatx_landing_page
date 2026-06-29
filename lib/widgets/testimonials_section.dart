import 'package:flutter/material.dart';

import '../responsive_layout.dart';

class TestimonialsSection extends StatefulWidget {
  final bool isVisible;

  const TestimonialsSection({super.key, this.isVisible = false});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;

  late List<AnimationController> _cardControllers;
  late List<Animation<double>> _cardFades;
  late List<Animation<Offset>> _cardSlides;

  static const List<_TestimonialData> _cards = [
    _TestimonialData(
      quote:
          '"UstadX transformed our hiring pipeline. The platform they built handles thousands of applications flawlessly. Their engineering quality is truly top-tier."',
      author: 'Mayank Pratap',
      role: 'CTO, SuperSourcing',
      rating: 5,
    ),
    _TestimonialData(
      quote:
          '"They delivered our mobile app weeks ahead of schedule without cutting corners. The user experience is butter smooth, and our customers love it."',
      author: 'Animesh Tiwari',
      role: 'Founder, Kifayat Card',
      rating: 5,
    ),
    _TestimonialData(
      quote:
          '"Finding an agency that understands both complex backend architecture and beautiful UI is rare. UstadX nailed both for our EdTech platform."',
      author: 'Waleed Ansari',
      role: 'Director, Fab Learner',
      rating: 5,
    ),
  ];

  @override
  void initState() {
    super.initState();

    // Header animation
    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeIn = CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeOutCubic,
    );
    _slideUp = Tween<Offset>(begin: const Offset(0, 30), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _headerController,
            curve: Curves.easeOutCubic,
          ),
        );

    // Per-card staggered animations
    _cardControllers = List.generate(
      _cards.length,
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      ),
    );
    _cardFades = _cardControllers
        .map(
          (c) =>
              CurvedAnimation(parent: c, curve: Curves.easeOutCubic)
                  as Animation<double>,
        )
        .toList();
    _cardSlides = _cardControllers
        .map(
          (c) => Tween<Offset>(
            begin: const Offset(0, 40),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: c, curve: Curves.easeOutCubic)),
        )
        .toList();
  }

  @override
  void didUpdateWidget(TestimonialsSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !oldWidget.isVisible) {
      _headerController.forward();
      for (int i = 0; i < _cardControllers.length; i++) {
        Future.delayed(Duration(milliseconds: 300 + i * 160), () {
          if (mounted) _cardControllers[i].forward();
        });
      }
    }
  }

  @override
  void dispose() {
    _headerController.dispose();
    for (final c in _cardControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveLayout.isMobile(context);
    final isLight = theme.brightness == Brightness.light;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: isMobile ? 24 : 48,
      ),
      decoration: BoxDecoration(
        // Light: distinct light-slate bg so white cards pop clearly
        // Dark: subtle tinted surface as before
        color: isLight
            ? const Color(0xFFF1F5F9)
            : theme.colorScheme.surfaceContainerHighest.withAlpha(60),
        border: isLight
            ? Border.symmetric(
                horizontal: BorderSide(
                  color: theme.colorScheme.outline.withAlpha(70),
                ),
              )
            : null,
      ),
      child: AnimatedBuilder(
        animation: _headerController,
        builder: (context, child) => Transform.translate(
          offset: _slideUp.value,
          child: Opacity(opacity: _fadeIn.value, child: child),
        ),
        child: Column(
          children: [
            // Section label
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: theme.colorScheme.primary.withAlpha(isLight ? 80 : 40),
                ),
                color: theme.colorScheme.primary.withAlpha(isLight ? 18 : 10),
              ),
              child: Text(
                'TESTIMONIALS',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontSize: 12,
                  letterSpacing: 2,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'WHAT OUR CLIENTS SAY',
              style: theme.textTheme.headlineLarge?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                'Don\'t just take our word for it. Here\'s what industry leaders have to say about our work.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: 56),

            // Top section divider
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Divider(
                color: theme.colorScheme.outline.withAlpha(isLight ? 90 : 40),
                height: 1,
              ),
            ),
            const SizedBox(height: 48),

            // Testimonial cards
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final cardWidth = isMobile
                      ? constraints.maxWidth
                      : (constraints.maxWidth - 64) / 3;

                  if (isMobile) {
                    return Column(
                      children: List.generate(_cards.length * 2 - 1, (i) {
                        if (i.isOdd) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Divider(
                              color: theme.colorScheme.outline.withAlpha(
                                isLight ? 90 : 40,
                              ),
                              height: 1,
                            ),
                          );
                        }
                        final idx = i ~/ 2;
                        return AnimatedBuilder(
                          animation: _cardControllers[idx],
                          builder: (context, child) => Transform.translate(
                            offset: _cardSlides[idx].value,
                            child: Opacity(
                              opacity: _cardFades[idx].value,
                              child: child,
                            ),
                          ),
                          child: _TestimonialCard(
                            data: _cards[idx],
                            cardWidth: cardWidth,
                          ),
                        );
                      }),
                    );
                  }

                  // Desktop — cards with vertical dividers between them
                  return IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(_cards.length * 2 - 1, (i) {
                        if (i.isOdd) {
                          return Container(
                            width: 1,
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            color: theme.colorScheme.outline.withAlpha(
                              isLight ? 90 : 40,
                            ),
                          );
                        }
                        final idx = i ~/ 2;
                        return AnimatedBuilder(
                          animation: _cardControllers[idx],
                          builder: (context, child) => Transform.translate(
                            offset: _cardSlides[idx].value,
                            child: Opacity(
                              opacity: _cardFades[idx].value,
                              child: child,
                            ),
                          ),
                          child: _TestimonialCard(
                            data: _cards[idx],
                            cardWidth: cardWidth,
                          ),
                        );
                      }),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 48),

            // Bottom section divider
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Divider(
                color: theme.colorScheme.outline.withAlpha(isLight ? 90 : 40),
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pure data holder (no Widget subtree) — safe as const.
class _TestimonialData {
  final String quote;
  final String author;
  final String role;
  final int rating;

  const _TestimonialData({
    required this.quote,
    required this.author,
    required this.role,
    required this.rating,
  });
}

class _TestimonialCard extends StatelessWidget {
  final _TestimonialData data;
  final double cardWidth;

  const _TestimonialCard({required this.data, required this.cardWidth});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return SizedBox(
      width: cardWidth,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          // Light: pure white card on slate bg → clearly distinct
          // Dark: dark surface
          color: isLight ? Colors.white : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isLight
                ? theme.colorScheme.outline.withAlpha(100)
                : theme.colorScheme.outline.withAlpha(40),
            width: 1.5,
          ),
          boxShadow: isLight
              ? [
                  BoxShadow(
                    color: Colors.black.withAlpha(18),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: theme.colorScheme.primary.withAlpha(14),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withAlpha(40),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rating stars
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < data.rating
                      ? Icons.star_rounded
                      : Icons.star_outline_rounded,
                  color: const Color(0xFFFFB800),
                  size: 20,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Quote — strong readable contrast in both themes
            Text(
              data.quote,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.75,
                fontStyle: FontStyle.italic,
                color: isLight
                    ? const Color(0xFF334155) // slate-700
                    : theme.colorScheme.onSurface.withAlpha(220),
              ),
            ),
            const SizedBox(height: 24),

            // Divider between quote and author
            Divider(
              color: theme.colorScheme.outline.withAlpha(isLight ? 80 : 40),
              height: 1,
            ),
            const SizedBox(height: 20),

            // Author row
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.primary.withAlpha(
                      isLight ? 25 : 20,
                    ),
                    border: Border.all(
                      color: theme.colorScheme.primary.withAlpha(
                        isLight ? 80 : 60,
                      ),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      data.author.substring(0, 1),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.author,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: isLight
                              ? const Color(0xFF1E293B) // slate-800
                              : theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        data.role,
                        style: TextStyle(
                          fontSize: 13,
                          color: isLight
                              ? const Color(0xFF64748B) // slate-500
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
    );
  }
}

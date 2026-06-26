import 'package:flutter/material.dart';

import '../responsive_layout.dart';

class TestimonialsSection extends StatefulWidget {
  final bool isVisible;

  const TestimonialsSection({super.key, this.isVisible = false});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection>
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
  void didUpdateWidget(TestimonialsSection oldWidget) {
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
          color: theme.colorScheme.surfaceContainerHighest.withAlpha(50),
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
                'TESTIMONIALS',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontSize: 12,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'WHAT OUR CLIENTS SAY',
              style: theme.textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                'Don\'t just take our word for it. Here\'s what industry leaders have to say about our work.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 72),

            // Testimonials grid
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final cardWidth = isMobile
                      ? constraints.maxWidth
                      : (constraints.maxWidth - 48) / 3;

                  return Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    alignment: WrapAlignment.center,
                    children: [
                      SizedBox(
                        width: cardWidth,
                        child: const _TestimonialCard(
                          quote:
                              '"UstadX transformed our hiring pipeline. The platform they built handles thousands of applications flawlessly. Their engineering quality is truly top-tier."',
                          author: 'Sarah Chen',
                          role: 'CTO, SuperSourcing',
                          rating: 5,
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: const _TestimonialCard(
                          quote:
                              '"They delivered our mobile app weeks ahead of schedule without cutting corners. The user experience is butter smooth, and our customers love it."',
                          author: 'James Wilson',
                          role: 'Founder, Kifayat Card',
                          rating: 5,
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: const _TestimonialCard(
                          quote:
                              '"Finding an agency that understands both complex backend architecture and beautiful UI is rare. UstadX nailed both for our EdTech platform."',
                          author: 'Dr. Emily Carter',
                          role: 'Director, Fab Learner',
                          rating: 5,
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

class _TestimonialCard extends StatelessWidget {
  final String quote;
  final String author;
  final String role;
  final int rating;

  const _TestimonialCard({
    required this.quote,
    required this.author,
    required this.role,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outline.withAlpha(40),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                index < rating ? Icons.star_rounded : Icons.star_outline_rounded,
                color: const Color(0xFFFFB800),
                size: 20,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Quote
          Text(
            quote,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.7,
              fontStyle: FontStyle.italic,
              color: theme.colorScheme.onSurface.withAlpha(220),
            ),
          ),
          const SizedBox(height: 32),
          // Author
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.primary.withAlpha(20),
                  border: Border.all(
                    color: theme.colorScheme.primary.withAlpha(60),
                  ),
                ),
                child: Center(
                  child: Text(
                    author.substring(0, 1),
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
                      author,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      role,
                      style: TextStyle(
                        fontSize: 13,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

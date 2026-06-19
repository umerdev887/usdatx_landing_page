import 'dart:math';

import 'package:flutter/material.dart';

class IndustrialParticleBackground extends StatefulWidget {
  const IndustrialParticleBackground({super.key});

  @override
  State<IndustrialParticleBackground> createState() =>
      _IndustrialParticleBackgroundState();
}

class _IndustrialParticleBackgroundState
    extends State<IndustrialParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final int _particleCount = 75; // Increased density by 1.5x
  final Random _random = Random();
  Size? _lastSize;
  Offset? _mousePosition;

  final List<Color> _palette = [
    const Color(0xFF00E5FF), // Neon Cyan
    const Color(0xFFFF007F), // Neon Pink
    const Color(0xFFFFEA00), // Electric Yellow
    const Color(0xFF00FF66), // Matrix Green
    const Color(0xFFB000FF), // Deep Purple
  ];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..addListener(() {
            _updateParticles();
          });
    _controller.repeat();
  }

  void _updateParticles() {
    if (_lastSize == null || _particles.isEmpty) return;

    for (var p in _particles) {
      // Interactive hover: Repel particles away from mouse
      if (_mousePosition != null) {
        final dx = p.x - _mousePosition!.dx;
        final dy = p.y - _mousePosition!.dy;
        final distance = sqrt(dx * dx + dy * dy);
        if (distance < 150) {
          final force = (150 - distance) / 150;
          p.dx += (dx / distance) * force * 1.5;
          p.dy += (dy / distance) * force * 1.5;
        }
      }

      // Add slight friction
      p.dx *= 0.98;
      p.dy *= 0.98;

      // Ensure minimum roaming speed
      final speed = sqrt(p.dx * p.dx + p.dy * p.dy);
      if (speed < 0.5 && speed > 0.01) {
        p.dx *= 1.05;
        p.dy *= 1.05;
      } else if (speed <= 0.01) {
        p.dx = _random.nextBool() ? 0.5 : -0.5;
        p.dy = _random.nextBool() ? 0.5 : -0.5;
      }

      // Speed cap
      if (speed > 5.0) {
        p.dx = (p.dx / speed) * 5.0;
        p.dy = (p.dy / speed) * 5.0;
      }

      p.x += p.dx;
      p.y += p.dy;

      // Bounce off the screen edges
      if (p.x <= 0 || p.x >= _lastSize!.width) {
        p.dx *= -1;
        p.x = p.x.clamp(0.0, _lastSize!.width);
      }
      if (p.y <= 0 || p.y >= _lastSize!.height) {
        p.dy *= -1;
        p.y = p.y.clamp(0.0, _lastSize!.height);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        if (_lastSize != size) {
          _lastSize = size;
          _particles.clear();
          for (int i = 0; i < _particleCount; i++) {
            _particles.add(
              Particle(
                x: _random.nextDouble() * size.width,
                y: _random.nextDouble() * size.height,
                // Micro-particles: radius 1-2.5px
                radius: 1.0 + _random.nextDouble() * 1.5,
                dx: (_random.nextDouble() - 0.5) * 2,
                dy: (_random.nextDouble() - 0.5) * 2,
                color: _palette[_random.nextInt(_palette.length)],
              ),
            );
          }
        }

        return MouseRegion(
          onHover: (event) {
            _mousePosition = event.localPosition;
          },
          onExit: (event) {
            _mousePosition = null;
          },
          child: RepaintBoundary(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  size: Size.infinite,
                  painter: _ParticlePainter(particles: _particles),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class Particle {
  double x;
  double y;
  final double radius;
  double dx;
  double dy;
  final Color color;

  Particle({
    required this.x,
    required this.y,
    required this.radius,
    required this.dx,
    required this.dy,
    required this.color,
  });
}

class _ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  _ParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final linePaint = Paint()..strokeWidth = 1;

    for (int i = 0; i < particles.length; i++) {
      final p1 = particles[i];
      paint.color = p1.color.withAlpha((0.8 * 255).toInt());
      canvas.drawCircle(Offset(p1.x, p1.y), p1.radius, paint);

      // Draw connecting lines between particles close to each other
      for (int j = i + 1; j < particles.length; j++) {
        final p2 = particles[j];
        final distance = sqrt(pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2));

        if (distance < 120) {
          // Calculate dynamic opacity based on distance
          final opacity = (1 - (distance / 120)) * 0.4; // max opacity 0.4
          linePaint.color = p1.color.withAlpha((opacity * 255).toInt());
          canvas.drawLine(Offset(p1.x, p1.y), Offset(p2.x, p2.y), linePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) {
    return true;
  }
}

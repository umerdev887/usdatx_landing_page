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
  final int _particleCount = 50;
  final Random _random = Random();
  Size? _lastSize;
  Offset? _mousePosition;

  // Professional cyan-blue spectrum only
  final List<Color> _palette = [
    const Color(0xFF00E5FF), // Neon Cyan
    const Color(0xFF00B8D4), // Darker Cyan
    const Color(0xFF40C4FF), // Light Blue
    const Color(0xFF448AFF), // Indigo Accent
    const Color(0xFF82B1FF), // Soft Blue
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
          p.dx += (dx / distance) * force * 1.2;
          p.dy += (dy / distance) * force * 1.2;
        }
      }

      // Slight friction
      p.dx *= 0.985;
      p.dy *= 0.985;

      // Ensure minimum roaming speed
      final speed = sqrt(p.dx * p.dx + p.dy * p.dy);
      if (speed < 0.3 && speed > 0.01) {
        p.dx *= 1.04;
        p.dy *= 1.04;
      } else if (speed <= 0.01) {
        p.dx = _random.nextBool() ? 0.4 : -0.4;
        p.dy = _random.nextBool() ? 0.4 : -0.4;
      }

      // Speed cap
      if (speed > 4.0) {
        p.dx = (p.dx / speed) * 4.0;
        p.dy = (p.dy / speed) * 4.0;
      }

      // Subtle pulsing opacity
      p.opacityPhase += 0.02;
      p.currentOpacity = 0.6 + 0.4 * sin(p.opacityPhase);

      p.x += p.dx;
      p.y += p.dy;

      // Bounce off screen edges
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
    _controller.stop();
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
                radius: 1.0 + _random.nextDouble() * 1.5,
                dx: (_random.nextDouble() - 0.5) * 1.5,
                dy: (_random.nextDouble() - 0.5) * 1.5,
                color: _palette[_random.nextInt(_palette.length)],
                opacityPhase: _random.nextDouble() * pi * 2,
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
  double opacityPhase;
  double currentOpacity;

  Particle({
    required this.x,
    required this.y,
    required this.radius,
    required this.dx,
    required this.dy,
    required this.color,
    this.opacityPhase = 0.0,
    this.currentOpacity = 0.8,
  });
}

class _ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  _ParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final linePaint = Paint()..strokeWidth = 0.8;

    for (int i = 0; i < particles.length; i++) {
      final p1 = particles[i];
      paint.color = p1.color.withAlpha((p1.currentOpacity * 200).toInt());
      canvas.drawCircle(Offset(p1.x, p1.y), p1.radius, paint);

      // Subtle glow around particle
      final glowPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = p1.color.withAlpha((p1.currentOpacity * 30).toInt());
      canvas.drawCircle(Offset(p1.x, p1.y), p1.radius * 3, glowPaint);

      // Draw connecting lines between nearby particles
      for (int j = i + 1; j < particles.length; j++) {
        final p2 = particles[j];
        final distance = sqrt(pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2));

        if (distance < 100) {
          final opacity = (1 - (distance / 100)) * 0.25;
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

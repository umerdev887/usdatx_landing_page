import 'dart:math';

import 'package:flutter/material.dart';

/// Animated tech grid that fills the hero right column — pulsing nodes
/// connected by faint lines, giving a data-network / circuit-board feel.
class TechGrid extends StatefulWidget {
  final double width;
  final double height;

  const TechGrid({super.key, required this.width, required this.height});

  @override
  State<TechGrid> createState() => _TechGridState();
}

class _TechGridState extends State<TechGrid>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: Size(widget.width, widget.height),
            painter: _TechGridPainter(
              progress: _controller.value,
              accentColor: Theme.of(context).colorScheme.primary,
            ),
          );
        },
      ),
    );
  }
}

class _TechGridPainter extends CustomPainter {
  final double progress;
  final Color accentColor;

  _TechGridPainter({required this.progress, required this.accentColor});

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(42); // Fixed seed for deterministic layout

    // Grid parameters
    const int cols = 8;
    const int rows = 8;
    final cellW = size.width / cols;
    final cellH = size.height / rows;

    // Generate node positions with slight jitter
    final nodes = <Offset>[];
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        final jitterX = (random.nextDouble() - 0.5) * cellW * 0.4;
        final jitterY = (random.nextDouble() - 0.5) * cellH * 0.4;
        nodes.add(Offset(
          cellW * (c + 0.5) + jitterX,
          cellH * (r + 0.5) + jitterY,
        ));
      }
    }

    // Draw connections
    final linePaint = Paint()
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        final dist = (nodes[i] - nodes[j]).distance;
        if (dist < cellW * 2) {
          final phase = sin(progress * pi * 2 + i * 0.3) * 0.5 + 0.5;
          final opacity = (1 - dist / (cellW * 2)) * 0.15 * phase;
          linePaint.color = accentColor.withAlpha((opacity * 255).toInt());
          canvas.drawLine(nodes[i], nodes[j], linePaint);
        }
      }
    }

    // Draw nodes
    final nodePaint = Paint()..style = PaintingStyle.fill;
    final glowPaint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < nodes.length; i++) {
      final pulse = sin(progress * pi * 2 + i * 0.5) * 0.5 + 0.5;
      final nodeSize = 2.0 + pulse * 1.5;
      final opacity = 0.3 + pulse * 0.5;

      // Glow
      glowPaint.color = accentColor.withAlpha((opacity * 40).toInt());
      canvas.drawCircle(nodes[i], nodeSize * 4, glowPaint);

      // Node
      nodePaint.color = accentColor.withAlpha((opacity * 200).toInt());
      canvas.drawCircle(nodes[i], nodeSize, nodePaint);
    }

    // Draw a few "active" data flow lines (bright, animated)
    final flowPaint = Paint()
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final flowPairs = [
      (0, 9),
      (9, 18),
      (18, 27),
      (3, 12),
      (12, 21),
      (5, 14),
      (14, 23),
    ];

    for (final pair in flowPairs) {
      if (pair.$1 < nodes.length && pair.$2 < nodes.length) {
        final flowProgress = (progress * 3 + pair.$1 * 0.2) % 1.0;
        final flowOpacity = sin(flowProgress * pi) * 0.6;
        if (flowOpacity > 0.05) {
          flowPaint.color =
              accentColor.withAlpha((flowOpacity * 255).toInt());
          canvas.drawLine(nodes[pair.$1], nodes[pair.$2], flowPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _TechGridPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

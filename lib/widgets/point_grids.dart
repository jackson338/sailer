import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:sailer/theme/sailer_theme.dart';

class MapGrid extends StatelessWidget {
  const MapGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          CustomPaint(
            size: Size(constraints.maxWidth, constraints.maxHeight),
            painter: const BottomPointGridPainter(),
          ),
          CustomPaint(
            size: Size(constraints.maxWidth, constraints.maxHeight),
            painter: const CenterPointGrid(),
          ),
        ],
      );
    });
  }
}

class BottomPointGridPainter extends CustomPainter {
  const BottomPointGridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = SailerTheme.lineColor
      ..strokeWidth = 0.25
      ..style = PaintingStyle.stroke;

    const double startX = 0;
    final double startY = size.height;
    const int lines = 30;
    final double radius = math.sqrt(size.width * size.width + size.height * size.height);

    for (int i = 0; i < lines; i++) {
      double angle = 2 * math.pi / lines * i;
      double x = startX - math.cos(angle) * radius;
      double y = startY - math.sin(angle) * radius;
      canvas.drawLine(Offset(startX, startY), Offset(x, y), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CenterPointGrid extends CustomPainter {
  const CenterPointGrid();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = SailerTheme.lineColor
      ..strokeWidth = 0.25
      ..style = PaintingStyle.stroke;
    final width = size.width + 9;

    final double startX = width;
    final double startY = size.height * 0.4;
    const int lines = 22;
    final double radius = math.sqrt(width * width + size.height * size.height);

    for (int i = 0; i < lines; i++) {
      double angle = 2 * math.pi / lines * i;
      double x = startX - math.cos(angle) * radius;
      double y = startY - math.sin(angle) * radius;
      canvas.drawLine(Offset(startX, startY), Offset(x, y), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

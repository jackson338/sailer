import 'package:flutter/material.dart';
import 'package:gemini_goals/theme/gemini_theme.dart';

class Sailboat extends StatelessWidget {
  const Sailboat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 70,
      width: 70,
      child: Column(
        children: [
          CustomPaint(
            painter: _SailPainter(),
          ),
          CustomPaint(
            painter: _HullPainter(),
          ),
        ],
      ),
    );
  }
}

class _SailPainter extends CustomPainter {
  const _SailPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fillPaint = Paint()
      // ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill
      ..color = GeminiTheme.widgetColor;

    double base = 37;
    double top = 4;
    double ends = 20;

    Offset p1 = Offset(ends, base);
    Offset p2 = Offset(top - 15, top);
    Offset p3 = Offset(-ends, base + 7);

    Offset c1 = Offset(ends - 3, top + 10);
    Offset c2 = Offset(top - 6, base - 10);
    Offset c3 = Offset(ends - 20, base + 10);

    Path path = Path();
    path.moveTo(p1.dx, p1.dy);
    path.quadraticBezierTo(c1.dx, c1.dy, p2.dx, p2.dy);
    path.quadraticBezierTo(c2.dx, c2.dy, p3.dx, p3.dy);
    path.quadraticBezierTo(c3.dx, c3.dy, p1.dx, p1.dy);
    // path.lineTo(p1.dx, p1.dy);

    canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _HullPainter extends CustomPainter {
  const _HullPainter();

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = GeminiTheme.widgetColor
      ..style = PaintingStyle.fill; // Filling the shape with black color

    // Assuming the arc's height is defined by the difference in y-values of P1 and P2
    double arcHeight = 60.0; // Example height of the arc
    double width = 20;
    double height = 55;

    // Define the points
    Offset p1 = Offset(-width, height - 8); // Start of the arc
    Offset p2 = Offset(width, height - 15); // End of the arc
    Offset p3 = Offset(-width, height); // Bottom left
    Offset p4 = Offset(width, height); // Bottom right

    Path path = Path();
    path.moveTo(p3.dx, p3.dy); // Start at P3
    path.lineTo(p1.dx, p1.dy); // Line to P1

    // Create an arc from P1 to P2
    path.arcToPoint(
      p2,
      radius: Radius.circular(arcHeight),
      clockwise: false,
    );

    path.lineTo(p4.dx, p4.dy); // Line to P4 from P2
    path.lineTo(p3.dx, p3.dy); // Close the path back to P3

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

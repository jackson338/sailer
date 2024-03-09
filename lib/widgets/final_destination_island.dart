import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailer/parent_cubit/parent_cubit.dart';
import 'package:sailer/theme/sailer_theme.dart';
import 'package:sailer/widgets/destination_marker.dart';

class FinalDestIsland extends StatelessWidget {
  const FinalDestIsland({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pc = context.read<ParentCubit>();
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        height: 160,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(constraints.maxWidth, constraints.maxHeight),
              painter: const _IslandPainter(),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DestMarker(
                    onTap: () => pc.toggleView(),
                    // onTap: () => Alligator.push(
                    //   context: context,
                    //   screen: const FinalDestView(),
                    // ),
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                'Final Destination',
                style: SailerTheme.title,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _IslandPainter extends CustomPainter {
  const _IslandPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const Gradient gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: SailerTheme.islandColors,
    );

    // Convert the gradient into a shader
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Paint fillPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = SailerTheme.borderColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const maxY = 150;

    final path = Path()
      ..moveTo(0, -10)
      ..lineTo(0, maxY * 0.45)
      ..lineTo(30, maxY * 0.54)
      ..lineTo(90, maxY * 0.8)
      ..lineTo(150, maxY * 0.9)
      ..lineTo(200, maxY * 0.9)
      ..lineTo(280, maxY * 0.95)
      ..lineTo(350, maxY * 0.89)
      ..lineTo(380, maxY * 0.8)
      ..lineTo(450, maxY * 0.55)
      ..lineTo(450, -10)
      ..close();

    canvas.drawPath(path, fillPaint);

    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

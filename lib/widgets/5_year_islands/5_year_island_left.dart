import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailer/alligator.dart';
import 'package:sailer/parent_cubit/parent_cubit.dart';
import 'package:sailer/theme/sailer_theme.dart';
import 'package:sailer/widgets/destination_marker.dart';
import 'package:sailer/widgets/destinations_list.dart';

class Year5IslandLeft extends StatefulWidget {
  final String destinationKey;
  const Year5IslandLeft({
    super.key,
    required this.destinationKey,
  });

  @override
  State<Year5IslandLeft> createState() => _Year5IslandLeftState();
}

class _Year5IslandLeftState extends State<Year5IslandLeft> {
  @override
  Widget build(BuildContext context) {
    final pc = context.read<ParentCubit>();
    double size = 120;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: size,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: SizedBox(
              width: size,
              height: size,
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size(size, size),
                    painter: const _IslandPainter(),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 20,
                    child: DestMarker(
                      onTap: () => Alligator.showBottomSheet(
                        context: context,
                        content: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 60.0, left: 8, right: 8, top: 8),
                          child: DestinationsList(
                            pc: pc,
                            destinationKey: widget.destinationKey,
                          ),
                        ),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomRight,
                          colors: SailerTheme.backgroundColors,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              widget.destinationKey,
              style: SailerTheme.subtitle,
            ),
          ),
        ],
      ),
    );
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

    final path = Path()
      ..moveTo(10, size.height * 0.3)
      ..lineTo(size.width * 0.4, size.height * 0.15)
      ..lineTo(size.width * 0.7, size.height * 0.2)
      ..lineTo(size.width * 0.8, size.height * 0.4)
      ..lineTo(size.width * 0.85, size.height * 0.7)
      ..lineTo(size.width * 0.7, size.height * 0.75)
      ..lineTo(size.width * 0.55, size.height * 0.8)
      ..lineTo(size.width * 0.2, size.height * 0.8)
      ..lineTo(0, size.height * 0.7)
      ..close();

    canvas.drawPath(path, fillPaint);

    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _RightDottedRoute extends CustomPainter {
  final double end;
  final double reverse;
  final bool right;
  const _RightDottedRoute({
    required this.end,
    required this.reverse,
    required this.right,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = SailerTheme.borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    for (int index = 0; index < (end / 10); index++) {
      if (right) {
        if (index % 2 == 0) {
          canvas.drawLine(
            Offset(index * 2.5, index * 10),
            Offset(index * 2.5 + 2.5, index * 10 + 10),
            paint,
          );
        }
      } else {
        int adjustedIndex = index - 24;
        if (adjustedIndex.isEven) {
          canvas.drawLine(
            Offset(
                reverse - adjustedIndex * 2.5,
                240 +
                    adjustedIndex * 10), // Reduced X increment from center to bottom left
            Offset(reverse - (adjustedIndex * 2.5 + 2.5),
                240 + adjustedIndex * 10 + 10), // Keep Y increment larger
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

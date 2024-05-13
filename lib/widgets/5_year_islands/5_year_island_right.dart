import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailer/alligator.dart';
import 'package:sailer/parent_cubit/parent_cubit.dart';
import 'package:sailer/theme/sailer_theme.dart';
import 'package:sailer/widgets/destination_marker.dart';
import 'package:sailer/widgets/destinations_list.dart';

class Year5IslandRight extends StatefulWidget {
  final String destinationKey;
  const Year5IslandRight({
    super.key,
    required this.destinationKey,
  });

  @override
  State<Year5IslandRight> createState() => _Year5IslandRightState();
}

class _Year5IslandRightState extends State<Year5IslandRight> {
  @override
  Widget build(BuildContext context) {
    final pc = context.read<ParentCubit>();
    double size = 120;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: size,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              widget.destinationKey,
              style: SailerTheme.subtitle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: SizedBox(
              width: size,
              height: size,
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size(size, size),
                    painter: const IslandPainter(),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 4,
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
        ],
      ),
    );
  }
}

class IslandPainter extends CustomPainter {
  const IslandPainter();

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
      ..moveTo(size.width * 0.2, size.height * 0.3)
      ..lineTo(size.width * 0.5, size.height * 0.18)
      ..lineTo(size.width * 0.7, size.height * 0.25)
      ..lineTo(size.width * 0.75, size.height * 0.4)
      ..lineTo(size.width * 0.8, size.height * 0.55)
      ..lineTo(size.width * 0.7, size.height * 0.75)
      ..lineTo(size.width * 0.55, size.height * 0.8)
      ..lineTo(size.width * 0.15, size.height * 0.8)
      ..lineTo(size.width * 0.1, size.height * 0.5)
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

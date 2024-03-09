import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sailer/models/destination_model.dart';
import 'package:sailer/parent_cubit/parent_cubit.dart';
import 'package:sailer/theme/sailer_theme.dart';

class DestinationsListWidget extends StatefulWidget {
  final DestinationModel dm;
  final int index;
  final String destinationKey;
  final ParentCubit pc;
  const DestinationsListWidget({
    super.key,
    required this.dm,
    required this.index,
    required this.destinationKey,
    required this.pc,
  });

  @override
  State<DestinationsListWidget> createState() => _DestinationsListWidgetState();
}

class _DestinationsListWidgetState extends State<DestinationsListWidget>
    with TickerProviderStateMixin {
  late Animation write;
  late AnimationController writeController;
  late Animation arrive;
  late AnimationController arriveController;
  Timer? _startAnimationTimer;
  bool arrived = false;
  bool init = false;
  @override
  void initState() {
    super.initState();
    if (!init) {
      setState(() {
        arrived = widget.dm.arrived;
        init = true;
      });
    }
// write animation
    writeController = AnimationController(
      duration: Duration(milliseconds: 400 + (widget.dm.title.length * 12)),
      vsync: this,
    );
    final curve = CurvedAnimation(parent: writeController, curve: Curves.ease);
    write = IntTween(begin: 0, end: widget.dm.title.length).animate(curve);
    arriveController = AnimationController(
      duration: Duration(milliseconds: widget.dm.title.length * 12),
      vsync: this,
    );

    // arrive animation
    final arriveCurve =
        CurvedAnimation(parent: arriveController, curve: Curves.easeInCubic);
    arrive = Tween(begin: 0.0, end: widget.dm.title.length * 9.0).animate(arriveCurve);
    _startAnimationTimer = Timer(Duration(milliseconds: widget.index * 200), () {
      if (mounted) {
        writeController.forward();
      }
    });
  }

  @override
  void dispose() {
    _startAnimationTimer?.cancel();
    if (mounted) {
      writeController.stop();
      arriveController.stop();
    }
    writeController.dispose();
    arriveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (arrived && arriveController.status == AnimationStatus.dismissed) {
      arriveController.stop();
      arriveController.forward();
    } else if (!arrived && arriveController.status == AnimationStatus.completed) {
      arriveController.stop();
      arriveController.reverse();
    }
    return GestureDetector(
      onTap: () {
        widget.pc.arriveDestination(
          destinationKey: widget.destinationKey,
          index: widget.index,
          arrive: !arrived,
        );
        setState(() {
          arrived = !arrived;
        });
      },
      child: Stack(
        children: [
          AnimatedBuilder(
              animation: write,
              builder: (context, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 12,
                  ),
                  child: Text(
                    widget.dm.title.substring(0, write.value),
                    style: SailerTheme.bodyText,
                  ),
                );
              }),
          AnimatedBuilder(
            animation: arrive,
            builder: (context, child) {
              return RepaintBoundary(
                child: arrive.value > 0
                    ? CustomPaint(
                        size: Size(arrive.value, 40),
                        painter: const CompletePainter(),
                      )
                    : const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CompletePainter extends CustomPainter {
  const CompletePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = SailerTheme.widgetColor
      ..strokeCap = StrokeCap.round;

    final random = Random();

    paint.strokeWidth = random.nextDouble() * 3 + 2;

    canvas.drawLine(
        Offset(10, size.height / 2), Offset(size.width - 10, size.height / 2), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

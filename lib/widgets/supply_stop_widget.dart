import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailer/parent_cubit/parent_cubit.dart';
import 'package:sailer/theme/sailer_theme.dart';
import 'package:sailer/widgets/destination_marker.dart';
import 'package:sailer/widgets/destination_widget.dart';

class SupplyStopWidget extends StatefulWidget {
  final String supplyStop;
  final bool right;
  final bool arrived;
  final String destinationKey;
  final int supplyIndex;
  const SupplyStopWidget({
    super.key,
    required this.supplyStop,
    required this.right,
    required this.arrived,
    required this.destinationKey,
    required this.supplyIndex,
  });

  @override
  State<SupplyStopWidget> createState() => _SupplyStopWidgetState();
}

class _SupplyStopWidgetState extends State<SupplyStopWidget>
    with TickerProviderStateMixin {
  late Animation arrive;
  late AnimationController arriveController;
  @override
  void initState() {
    super.initState();

    double length = 0;
    double maxWidth = 300.0;
    for (int i = 0; i <= widget.supplyStop.length; i++) {
      if (length < maxWidth) {
        length += 9;
      }
    }

    arriveController = AnimationController(
      duration: Duration(milliseconds: widget.supplyStop.length * 12),
      vsync: this,
    );
    final arriveCurve =
        CurvedAnimation(parent: arriveController, curve: Curves.easeInCubic);
    arrive = Tween(begin: 0.0, end: length).animate(arriveCurve);
  }

  @override
  void dispose() {
    if (mounted) {
      arriveController.stop();
    }
    arriveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pc = context.read<ParentCubit>();
    if (mounted) {
      if (arriveController.status == AnimationStatus.completed && !widget.arrived) {
        arriveController.reverse();
      } else if (arriveController.status == AnimationStatus.dismissed && widget.arrived) {
        arriveController.forward();
      }
    }
    return Row(
      mainAxisAlignment: widget.right ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        if (!widget.right)
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 12,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    widget.supplyStop,
                    style: SailerTheme.bodyText,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DestMarker(
            onTap: () {
              pc.arriveSupplyStop(
                destinationKey: widget.destinationKey,
                supplyIndex: widget.supplyIndex,
                arrive: !widget.arrived,
              );
            },
          ),
        ),
        if (widget.right)
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 12,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    widget.supplyStop,
                    style: SailerTheme.bodyText,
                  ),
                ),
              ),
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
      ],
    );
  }
}

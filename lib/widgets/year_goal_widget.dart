import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gemini_goals/parent_cubit/parent_cubit.dart';
import 'package:gemini_goals/theme/gemini_theme.dart';

class YearGoal extends StatefulWidget {
  final String destinationKey;
  const YearGoal({
    super.key,
    required this.destinationKey,
  });

  @override
  State<YearGoal> createState() => _YearGoalState();
}

class _YearGoalState extends State<YearGoal> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late AnimationController _borderController;
  late Animation<double> _borderAnimation;
  late OverlayEntry _overlayEntry;
  bool showText = true;
  final gKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _borderController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _borderAnimation = Tween<double>(begin: 10.0, end: 50.0).animate(_borderController);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showOverlay(BuildContext context) {
    RenderBox? renderBox = gKey.currentContext?.findRenderObject() as RenderBox?;
    Offset position = const Offset(0, 0);
    if (renderBox != null) {
      position = renderBox.localToGlobal(Offset.zero);
    }
    _overlayEntry = OverlayEntry(
      builder: (context) => AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          bool type = _animation.value < 0.6 ? true : false;
          return Positioned(
            top: type
                ? position.dy - MediaQuery.of(context).size.height * _animation.value
                : 0,
            child: GestureDetector(
              onTap: () => _controller.reverse()
                ..whenComplete(
                  () {
                    _overlayEntry.remove();
                    setState(() {
                      showText = true;
                    });
                  },
                ),
              child: Container(
                color: GeminiTheme.widgetColor.withOpacity(_animation.value),
                alignment: Alignment.center,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * _animation.value,
                      decoration: BoxDecoration(
                        color: GeminiTheme.widgetColor,
                        borderRadius: BorderRadius.circular(10 * (1 - _animation.value)),
                      ),
                      child: YearGoalOverlay(
                        destinationKey: widget.destinationKey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
    Overlay.of(context).insert(_overlayEntry);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final pc = context.read<ParentCubit>();
    double size = 75;
    return GestureDetector(
      onTapUp: (_) {
        _borderController.reverse().whenComplete(() {
          _showOverlay(context);
        });
      },
      onTapDown: (_) {
        _borderController.forward();
        setState(() {
          showText = false;
        });
      },
      child: AnimatedBuilder(
        animation: _borderAnimation,
        builder: (context, _) {
          return Container(
            key: gKey,
            width: MediaQuery.of(context).size.width,
            height: size,
            decoration: BoxDecoration(
              color: GeminiTheme.widgetColor,
              borderRadius: BorderRadius.circular(_borderAnimation.value),
            ),
            child: showText
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.0),
                        child: Icon(
                          FontAwesomeIcons.umbrellaBeach,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        widget.destinationKey,
                        style: GeminiTheme.subtitle,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

class YearGoalOverlay extends StatelessWidget {
  final String destinationKey;
  const YearGoalOverlay({
    super.key,
    required this.destinationKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0),
              child: Icon(
                FontAwesomeIcons.umbrellaBeach,
                color: Colors.white,
              ),
            ),
            Text(
              destinationKey,
              style: GeminiTheme.subtitle,
            ),
          ],
        )
      ],
    );
  }
}

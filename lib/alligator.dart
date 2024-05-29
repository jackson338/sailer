import 'package:flutter/material.dart';

class Alligator {
  static void push({
    required BuildContext context,
    required Widget screen,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static void show80bottomSheet(
    BuildContext context,
    Widget content,
    Color backgroundColor,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.83,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: SingleChildScrollView(
            child: content,
          ),
        );
      },
    );
  }

  static void showBottomSheet({
    required BuildContext context,
    required Widget content,
    Color? backgroundColor,
    LinearGradient? gradient,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(10),
                color: backgroundColor),
            child: content,
          ),
        );
      },
    );
  }
}

class OverlayNavigation extends StatefulWidget {
  final Widget screen;
  const OverlayNavigation({
    super.key,
    required this.screen,
  });

  @override
  State<OverlayNavigation> createState() => _OverlayNavigationState();
}

class _OverlayNavigationState extends State<OverlayNavigation> {
  @override
  Widget build(BuildContext context) {
    return widget.screen;
  }
}

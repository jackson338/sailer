import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sailer/theme/sailer_theme.dart';

class BoatTapWidget extends StatefulWidget {
  const BoatTapWidget({
    super.key,
  });

  @override
  State<BoatTapWidget> createState() => _BoatTapWidgetState();
}

class _BoatTapWidgetState extends State<BoatTapWidget> with TickerProviderStateMixin {
  late Animation fill;
  late AnimationController fillController;
  late Animation fade;
  late AnimationController fadeController;
  @override
  void initState() {
    super.initState();

    // Fade Animation
    fadeController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    final curve2 = CurvedAnimation(parent: fadeController, curve: Curves.easeIn);
    fade = Tween(begin: 0.4, end: 0.0).animate(curve2);
    fade.addStatusListener(reset);

// Fill Animation
    fillController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    final curve1 =
        CurvedAnimation(parent: fillController, curve: Curves.fastEaseInToSlowEaseOut);
    fill = Tween(begin: 0.0, end: 100.0).animate(curve1);
    Timer(const Duration(seconds: 1), () {
      fillController.forward().whenComplete(() => fadeController.forward());
    });
  }

  void reset(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      fillController.reset();
      fadeController.reset();
      Timer(const Duration(seconds: 8, milliseconds: 500), () {
        fillController.forward().whenComplete(() => fadeController.forward());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 70,
      child: Center(
        child: AnimatedBuilder(
          animation: fade,
          builder: (context, child) {
            return AnimatedBuilder(
              animation: fill,
              builder: (context, child) {
                return Opacity(
                  opacity: fade.value,
                  child: Container(
                    height: fill.value,
                    width: fill.value,
                    decoration: BoxDecoration(
                      color: SailerTheme.backgroundColors[1],
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

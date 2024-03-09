import 'dart:async';

import 'package:flutter/material.dart';

class DestMarker extends StatefulWidget {
  final Function() onTap;
  const DestMarker({
    super.key,
    required this.onTap,
  });

  @override
  State<DestMarker> createState() => _DestMarkerState();
}

class _DestMarkerState extends State<DestMarker> with TickerProviderStateMixin {
  late Animation fill;
  late AnimationController fillController;
  late Animation fade;
  late AnimationController fadeController;
  @override
  void initState() {
    super.initState();

    // Fade Animation
    fadeController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    final curve2 = CurvedAnimation(parent: fadeController, curve: Curves.easeIn);
    fade = Tween(begin: 0.5, end: 0.0).animate(curve2);
    fade.addStatusListener(reset);

// Fill Animation
    fillController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    final curve1 = CurvedAnimation(parent: fillController, curve: Curves.ease);
    fill = Tween(begin: 0.0, end: 30.0).animate(curve1);
    fillController.forward().whenComplete(() => fadeController.forward());
  }

  void reset(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      fillController.reset();
      fadeController.reset();
      Timer(const Duration(seconds: 9, milliseconds: 800), () {
        fillController.forward().whenComplete(() => fadeController.forward());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              Center(
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

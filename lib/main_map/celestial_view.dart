import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailer/parent_cubit/parent_cubit.dart';
import 'package:sailer/theme/sailer_theme.dart';

class CelestialView extends StatelessWidget {
  final Function() returnToMap;
  const CelestialView({
    super.key,
    required this.returnToMap,
  });

  @override
  Widget build(BuildContext context) {
    final pc = context.read<ParentCubit>();
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: SailerTheme.celestialGradient,
        ),
      ),
      child: CustomPaint(
        painter: StarrySkyPainter(),
        child: SafeArea(
          child: Column(
            children: [
              ...List.generate(
                pc.state.celestialGoals.length,
                (index) => Align(
                  alignment: index.isEven ? Alignment.centerLeft : Alignment.centerRight,
                  child: Stars(
                    goal: pc.state.celestialGoals[index],
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: returnToMap,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Tap to return',
                      style: SailerTheme.subtitle1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Stars extends StatelessWidget {
  final String goal;
  const Stars({
    super.key,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Text(
          goal,
          style: SailerTheme.bodyText.copyWith(
            color: SailerTheme.starColor,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}

class StarrySkyPainter extends CustomPainter {
  final int numberOfStars;
  final Random random = Random();

  StarrySkyPainter({this.numberOfStars = 9000});

  @override
  void paint(Canvas canvas, Size size) {
    Paint starPaint = Paint()
      ..color = SailerTheme.starColors[random.nextInt(SailerTheme.starColors.length - 1)];
    for (int i = 0; i < numberOfStars; i++) {
      starPaint.color =
          SailerTheme.starColors[random.nextInt(SailerTheme.starColors.length - 1)];
      // Generate a random position for each star
      final position = Offset(
          random.nextDouble() * size.width, random.nextDouble() * size.height - 60);
      // Optionally, randomize the star size as well
      final starSize = random.nextDouble() * 1.05 + 0.05; // Stars size from 1 to 3
      // Draw the star
      canvas.drawCircle(position, starSize, starPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

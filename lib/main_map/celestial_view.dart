import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_goals/parent_cubit/parent_cubit.dart';
import 'package:gemini_goals/theme/gemini_theme.dart';

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
        gradient: RadialGradient(
          center: Alignment.bottomCenter,
          colors: GeminiTheme.celestialGradient,
          radius: 1.5,
        ),
      ),
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
                    style: GeminiTheme.subtitle,
                  ),
                ),
              ),
            ),
          ],
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
          style: GeminiTheme.bodyText.copyWith(
            color: GeminiTheme.starColor,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}

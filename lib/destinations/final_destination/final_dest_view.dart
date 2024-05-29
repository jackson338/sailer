import 'package:flutter/material.dart';
import 'package:gemini_goals/theme/gemini_theme.dart';

class FinalDestView extends StatelessWidget {
  const FinalDestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GeminiTheme.lineColor,
        title: Text(
          'Final Destination',
          style: GeminiTheme.title,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            colors: GeminiTheme.islandColors,
          ),
        ),
      ),
    );
  }
}

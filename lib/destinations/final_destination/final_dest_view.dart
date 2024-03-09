import 'package:flutter/material.dart';
import 'package:sailer/theme/sailer_theme.dart';

class FinalDestView extends StatelessWidget {
  const FinalDestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SailerTheme.lineColor,
        title: Text(
          'Final Destination',
          style: SailerTheme.title,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            colors: SailerTheme.islandColors,
          ),
        ),
      ),
    );
  }
}

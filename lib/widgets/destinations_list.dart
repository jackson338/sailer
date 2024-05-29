import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gemini_goals/parent_cubit/parent_cubit.dart';
import 'package:gemini_goals/theme/gemini_theme.dart';
import 'package:gemini_goals/widgets/destination_widget.dart';

class DestinationsList extends StatelessWidget {
  final String destinationKey;
  final ParentCubit pc;
  const DestinationsList({
    super.key,
    required this.destinationKey,
    required this.pc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: GeminiTheme.lineColor,
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            top: 0,
            bottom: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 17.0, sigmaY: 17.0),
                child: Container(
                  color: GeminiTheme.islandColors[1].withOpacity(0.2),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              pc.state.destinations[destinationKey]!.length,
              (index) => DestinationsListWidget(
                dm: pc.state.destinations[destinationKey]![index],
                index: index,
                destinationKey: destinationKey,
                pc: pc,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

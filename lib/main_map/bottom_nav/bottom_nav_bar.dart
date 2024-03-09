import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sailer/theme/sailer_theme.dart';
import 'package:sailer/widgets/sailboat/sailboat.dart';

class BottomNavBar extends StatelessWidget {
  final BoxConstraints constraints;
  final Function() sextant;
  const BottomNavBar({
    super.key,
    required this.constraints,
    required this.sextant,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 0,
          left: 0,
          top: 0,
          bottom: 0,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 24.3, sigmaY: 24.3),
              child: Container(
                color: SailerTheme.islandColors[0].withOpacity(0.53),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 90,
          width: constraints.maxWidth,
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: sextant,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 9.0),
                    child: Icon(
                      FontAwesomeIcons.mountain,
                      size: 50,
                    ),
                  ),
                ),
                const Sailboat(),
                const Padding(
                  padding: EdgeInsets.only(top: 9.0),
                  child: Icon(
                    FontAwesomeIcons.fileCirclePlus,
                    color: SailerTheme.widgetColor,
                    size: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

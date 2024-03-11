import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sailer/parent_cubit/parent_cubit.dart';
import 'package:sailer/theme/sailer_theme.dart';

class AddSheet extends StatelessWidget {
  final ParentCubit cubit;
  final Function() onTap;
  const AddSheet({
    super.key,
    required this.cubit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: SailerTheme.backgroundColors,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                right: 0,
                left: 0,
                top: 0,
                bottom: 0,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 23.0, sigmaY: 23.0),
                    child: Container(
                      color: SailerTheme.islandColors[1].withOpacity(0.2),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: SailerTheme.lineColor,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Text(
                          'Add Supply Stop',
                          style: SailerTheme.subtitle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Text(
                          'Add Destination Detail',
                          style: SailerTheme.subtitle1,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          onTap();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          child: Text(
                            'Add Destination',
                            style: SailerTheme.subtitle1,
                          ),
                        ),
                      ),
                    ],
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

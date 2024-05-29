import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_goals/main_map/bottom_nav/bottom_nav_bar.dart';
import 'package:gemini_goals/main_map/celestial_view.dart';
import 'package:gemini_goals/models/supply_stop.dart';
import 'package:gemini_goals/parent_cubit/parent_cubit.dart';
import 'package:gemini_goals/parent_cubit/parent_state.dart';
import 'package:gemini_goals/theme/gemini_theme.dart';
import 'package:gemini_goals/widgets/year_goal_widget.dart';
import 'package:gemini_goals/widgets/point_grids.dart';
import 'package:gemini_goals/widgets/sub_goal.dart';

class MainMapView extends StatefulWidget {
  const MainMapView({super.key});

  @override
  State<MainMapView> createState() => _MainMapViewState();
}

class _MainMapViewState extends State<MainMapView> {
  ScrollController sc = ScrollController(initialScrollOffset: 0.0);
  final celestialKey = GlobalKey();

  void scrollTo(double offset) {
    sc.animateTo(
      -offset,
      duration: const Duration(milliseconds: 1200),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: BlocProvider(
          create: (context) => ParentCubit(),
          child: BlocBuilder<ParentCubit, ParentState>(
            builder: (context, state) {
              // final pc = context.read<ParentCubit>();
              return SizedBox(
                height: constraints.maxHeight,
                child: ListView(
                  padding: const EdgeInsets.all(0),
                  controller: sc,
                  physics: const NeverScrollableScrollPhysics(),
                  reverse: true,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              gradient: RadialGradient(
                                center: Alignment.topCenter,
                                radius: 1.4,
                                colors: GeminiTheme.backgroundColors,
                              ),
                            ),
                          ),
                          const MapGrid(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                              reverse: true,
                              itemCount: state.destinations.keys.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 70.0,
                                  left: 16,
                                  right: 16,
                                ),
                                child: DestinationsAndSupplyStops(
                                  destinationKey: state.destinations.keys.toList()[index],
                                  state: state,
                                  index: index,
                                  supplyStops: state.supplyStops[
                                      state.destinations.keys.toList()[index]],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: BottomNavBar(
                              sextant: () {
                                final RenderBox renderBox = celestialKey.currentContext
                                    ?.findRenderObject() as RenderBox;
                                final position = renderBox.localToGlobal(Offset.zero);
                                final offset = position.dy;

                                scrollTo(offset);
                              },
                              constraints: constraints,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CelestialView(
                      returnToMap: () {
                        scrollTo(0);
                      },
                      key: celestialKey,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    });
  }
}

class DestinationsAndSupplyStops extends StatelessWidget {
  final ParentState state;
  final int index;
  final List<SupplyStop>? supplyStops;
  final String destinationKey;
  const DestinationsAndSupplyStops({
    super.key,
    required this.state,
    required this.index,
    this.supplyStops,
    required this.destinationKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: YearGoal(
            destinationKey: state.destinations.keys.toList()[index],
          ),
        ),
        if (supplyStops != null)
          ...List.generate(
            supplyStops!.length,
            (supplyIndex) => SubGoalWidget(
              supplyStop: supplyStops![supplyIndex],
              destinationKey: destinationKey,
              supplyIndex: supplyIndex,
            ),
          ),
      ],
    );
  }
}

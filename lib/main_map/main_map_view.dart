import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailer/main_map/bottom_nav/bottom_nav_bar.dart';
import 'package:sailer/main_map/celestial_view.dart';
import 'package:sailer/models/supply_stop.dart';
import 'package:sailer/parent_cubit/parent_cubit.dart';
import 'package:sailer/parent_cubit/parent_state.dart';
import 'package:sailer/theme/sailer_theme.dart';
import 'package:sailer/widgets/5_year_islands/5_year_island_left.dart';
import 'package:sailer/widgets/5_year_islands/5_year_island_right.dart';
import 'package:sailer/widgets/point_grids.dart';
import 'package:sailer/widgets/supply_stop_widget.dart';

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
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomLeft,
                                colors: SailerTheme.backgroundColors,
                              ),
                            ),
                          ),
                          const MapGrid(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                              reverse: true,
                              itemCount: state.destinations.keys.length,
                              itemBuilder: (context, index) => index == 0
                                  ? Padding(
                                      padding: const EdgeInsets.only(bottom: 70.0),
                                      child: DestinationsAndSupplyStops(
                                        destinationKey:
                                            state.destinations.keys.toList()[index],
                                        right: index.isEven,
                                        state: state,
                                        index: index,
                                        supplyStops: state.supplyStops[
                                            state.destinations.keys.toList()[index]],
                                      ),
                                    )
                                  : DestinationsAndSupplyStops(
                                      destinationKey:
                                          state.destinations.keys.toList()[index],
                                      right: index.isEven,
                                      state: state,
                                      index: index,
                                      supplyStops: state.supplyStops[
                                          state.destinations.keys.toList()[index]],
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
  final bool right;
  final int index;
  final List<SupplyStop>? supplyStops;
  final String destinationKey;
  const DestinationsAndSupplyStops({
    super.key,
    required this.right,
    required this.state,
    required this.index,
    this.supplyStops,
    required this.destinationKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        right
            ? Center(
                child: Year5IslandRight(
                  destinationKey: state.destinations.keys.toList()[index],
                ),
              )
            : Center(
                child: Year5IslandLeft(
                  destinationKey: state.destinations.keys.toList()[index],
                ),
              ),
        if (supplyStops != null)
          ...List.generate(
            supplyStops!.length,
            (supplyIndex) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SupplyStopWidget(
                supplyStop: supplyStops![supplyIndex].title,
                right: supplyIndex.isEven,
                arrived: supplyStops![supplyIndex].arrived,
                destinationKey: destinationKey,
                supplyIndex: supplyIndex,
              ),
            ),
          ),
      ],
    );
  }
}

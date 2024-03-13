import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sailer/main_map/bottom_nav/pages/destination_page.dart';
import 'package:sailer/main_map/bottom_nav/pages/sub_destination_page.dart';
import 'package:sailer/main_map/bottom_nav/pages/supply_stops_page.dart';
import 'package:sailer/parent_cubit/parent_cubit.dart';

class DestinationSheet extends StatefulWidget {
  final ParentCubit cubit;
  const DestinationSheet({
    super.key,
    required this.cubit,
  });

  @override
  State<DestinationSheet> createState() => _DestinationSheetState();
}

class _DestinationSheetState extends State<DestinationSheet> {
  List<String> destinations = [];
  int pageIndex = 1;
  int destIndex = 0;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    widget.cubit.state.destinations.forEach(
      (key, value) {
        destinations.insert(0, key);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(milliseconds: 100),
      () => controller.jumpToPage(pageIndex),
    );
    List<Widget> pages = [
      SubDestinationPage(
        cubit: widget.cubit,
        dest: destinations[destIndex],
      ),
      DestinationPage(cubit: widget.cubit),
      SupplyStopsPage(
        cubit: widget.cubit,
        dest: destinations[destIndex],
      ),
    ];
    return PageView.builder(
      controller: controller,
      itemBuilder: (context, index) {
        return pages[index];
      },
    );
  }
}

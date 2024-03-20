import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sailer/main_map/bottom_nav/pages/destination_page.dart';
import 'package:sailer/main_map/bottom_nav/pages/sub_destination_page.dart';
import 'package:sailer/main_map/bottom_nav/pages/supply_stops_page.dart';
import 'package:sailer/parent_cubit/parent_cubit.dart';
import 'package:sailer/theme/sailer_theme.dart';

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

  void navigate(int index) {
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeIn,
    );
  }

  void selectDest(int ind) {
    setState(() {
      destIndex = ind;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('working');
    Timer(
      const Duration(milliseconds: 100),
      () => controller.jumpToPage(pageIndex),
    );
    List<Widget> pages = [
      SubDestinationPage(
        cubit: widget.cubit,
        dest: destinations[destIndex],
      ),
      DestinationPage(
        destIndex: destIndex,
        cubit: widget.cubit,
        selectDest: (int ind) => selectDest(ind),
      ),
      SupplyStopsPage(
        cubit: widget.cubit,
        dest: destinations[destIndex],
      ),
    ];
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        height: constraints.maxHeight * 0.8,
        width: constraints.maxWidth * 0.8,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    pageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return pages[index];
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                3,
                (index) => _selector(
                  pageIndex == index,
                  index,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _selector(
    bool selected,
    int index,
  ) {
    return GestureDetector(
      onTap: () => navigate(index),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: selected ? SailerTheme.widgetColor : SailerTheme.backgroundColors[1],
        ),
        height: 30,
        width: 30,
      ),
    );
  }
}

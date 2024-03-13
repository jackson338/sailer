import 'package:flutter/material.dart';
import 'package:sailer/models/supply_stop.dart';
import 'package:sailer/parent_cubit/parent_cubit.dart';
import 'package:sailer/theme/sailer_theme.dart';

class SupplyStopsPage extends StatefulWidget {
  final String dest;
  final ParentCubit cubit;
  const SupplyStopsPage({
    super.key,
    required this.cubit,
    required this.dest,
  });

  @override
  State<SupplyStopsPage> createState() => _SupplyStopsPageState();
}

class _SupplyStopsPageState extends State<SupplyStopsPage> {
  late List<SupplyStop> supplyStops;
  @override
  void initState() {
    super.initState();

    supplyStops = widget.cubit.state.supplyStops[widget.dest] ?? [];
  }

  void _add(
    String newSupply,
  ) =>
      setState(() {
        supplyStops.add(
          SupplyStop(
            title: newSupply,
            arrived: false,
            id: DateTime.now().toString(),
          ),
        );
      });

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Supply Stops',
                style: SailerTheme.title,
              ),
              TextField(
                style: SailerTheme.bodyText,
                controller: controller,
                keyboardAppearance: Brightness.dark,
                onSubmitted: (val) {
                  _add(val);
                  widget.cubit.addSupplyStop(widget.dest, val);
                  controller.text = '';
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: supplyStops.length,
                  itemBuilder: (context, index) => Text(
                    supplyStops[index].title,
                    style: SailerTheme.bodyText,
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

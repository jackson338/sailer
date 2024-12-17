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
  List<SupplyStop> supplyStops = [];
  @override
  void initState() {
    super.initState();
    if (widget.cubit.state.supplyStops[widget.dest] != null) {
      for (final sp in widget.cubit.state.supplyStops[widget.dest]!) {
        supplyStops.add(sp);
      }
    }
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
  void dispose() {
    super.dispose();
  }

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
                style: SailerTheme.subtitle,
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
                  itemBuilder: (context, index) => Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.cubit.deleteSupplyStop(
                              supplyStops[index], widget.dest);
                          setState(() {
                            supplyStops.removeWhere(
                                (s) => s.id == supplyStops[index].id);
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.delete,
                            color: Color(0xFFBC6767),
                            size: 28,
                          ),
                        ),
                      ),
                      Text(
                        supplyStops[index].title,
                        style: SailerTheme.subtitle,
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

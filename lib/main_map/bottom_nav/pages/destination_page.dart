import 'package:flutter/material.dart';
import 'package:sailer/parent_cubit/parent_cubit.dart';
import 'package:sailer/theme/sailer_theme.dart';

class DestinationPage extends StatefulWidget {
  final ParentCubit cubit;
  final Function(int index) selectDest;
  final int destIndex;
  const DestinationPage({
    super.key,
    required this.cubit,
    required this.selectDest,
    required this.destIndex,
  });

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  List<String> destinations = [];
  int destIndex = 0;
  @override
  void initState() {
    super.initState();
    destIndex = widget.destIndex;

    widget.cubit.state.destinations.forEach(
      (key, value) {
        destinations.insert(0, key);
      },
    );
  }

  void _add(
    String newDest,
  ) =>
      setState(() {
        destinations.insert(0, newDest);
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
                'Destinations',
                style: SailerTheme.title,
              ),
              TextField(
                style: SailerTheme.title,
                controller: controller,
                keyboardAppearance: Brightness.dark,
                onSubmitted: (val) {
                  _add(val);
                  widget.cubit.addDestination(val);
                  controller.text = '';
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: destinations.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      widget.selectDest(index);
                      setState(() {
                        destIndex = index;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          destinations[index],
                          style: SailerTheme.title,
                        ),
                        destIndex == index
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: SailerTheme.islandColor,
                                ),
                                height: 30,
                                width: 30,
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
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

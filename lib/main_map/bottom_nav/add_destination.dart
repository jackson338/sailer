import 'package:flutter/material.dart';
import 'package:sailer/parent_cubit/parent_cubit.dart';
import 'package:sailer/theme/sailer_theme.dart';

class AddDestination extends StatefulWidget {
  final ParentCubit cubit;
  const AddDestination({
    super.key,
    required this.cubit,
  });

  @override
  State<AddDestination> createState() => _AddDestinationState();
}

class _AddDestinationState extends State<AddDestination> {
  List<String> destinations = [];
  @override
  void initState() {
    super.initState();

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
              TextField(
                style: SailerTheme.title,
                controller: controller,
                keyboardAppearance: Brightness.dark,
                onSubmitted: (val) {
                  _add(val);
                  widget.cubit.addDestination(val);
                  controller.text = '';
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: destinations.length,
                  itemBuilder: (context, index) => Text(
                    destinations[index],
                    style: SailerTheme.title,
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

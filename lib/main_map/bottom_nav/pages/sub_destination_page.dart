import 'package:flutter/material.dart';
import 'package:gemini_goals/models/destination_model.dart';
import 'package:gemini_goals/parent_cubit/parent_cubit.dart';
import 'package:gemini_goals/theme/gemini_theme.dart';

class SubDestinationPage extends StatefulWidget {
  final String dest;
  final ParentCubit cubit;
  const SubDestinationPage({
    super.key,
    required this.cubit,
    required this.dest,
  });

  @override
  State<SubDestinationPage> createState() => _SubDestinationPageState();
}

class _SubDestinationPageState extends State<SubDestinationPage> {
  List<DestinationModel> subDestinations = [];
  @override
  void initState() {
    super.initState();
    if (widget.cubit.state.destinations[widget.dest] != null) {
      for (final sd in widget.cubit.state.destinations[widget.dest]!) {
        subDestinations.add(sd);
      }
    }
  }

  void _add(
    String newDest,
  ) =>
      setState(() {
        subDestinations.add(
          DestinationModel(
            title: newDest,
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
          colors: GeminiTheme.backgroundColors,
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
                'Sub Destinations',
                style: GeminiTheme.title,
              ),
              TextField(
                style: GeminiTheme.bodyText,
                controller: controller,
                keyboardAppearance: Brightness.dark,
                onSubmitted: (val) {
                  _add(val);
                  widget.cubit.addSubDestination(widget.dest, val);
                  controller.text = '';
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: subDestinations.length,
                  itemBuilder: (context, index) => Text(
                    subDestinations[index].title,
                    style: GeminiTheme.bodyText,
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

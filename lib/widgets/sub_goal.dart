import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gemini_goals/models/supply_stop.dart';
import 'package:gemini_goals/parent_cubit/parent_cubit.dart';
import 'package:gemini_goals/theme/gemini_theme.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class SubGoalWidget extends StatefulWidget {
  final SupplyStop supplyStop;
  // final bool arrived;
  final String destinationKey;
  final int supplyIndex;
  const SubGoalWidget({
    super.key,
    required this.supplyStop,
    // required this.arrived,
    required this.destinationKey,
    required this.supplyIndex,
  });

  @override
  State<SubGoalWidget> createState() => _SubGoalWidgetState();
}

class _SubGoalWidgetState extends State<SubGoalWidget> with TickerProviderStateMixin {
  late Animation arrive;
  late AnimationController arriveController;
  final gKey = GlobalKey();
  late AnimationController _controller;
  late Animation<double> _animation;
  late AnimationController _borderController;
  late Animation<double> _borderAnimation;
  late OverlayEntry _overlayEntry;
  bool showText = true;

  @override
  void initState() {
    super.initState();

    double length = 0;
    double maxWidth = 300.0;
    for (int i = 0; i <= widget.supplyStop.title.length; i++) {
      if (length < maxWidth) {
        length += 9;
      }
    }

    arriveController = AnimationController(
      duration: Duration(milliseconds: widget.supplyStop.title.length * 12),
      vsync: this,
    );
    final arriveCurve =
        CurvedAnimation(parent: arriveController, curve: Curves.easeInCubic);
    arrive = Tween(begin: 0.0, end: length).animate(arriveCurve);

    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _borderController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _borderAnimation = Tween<double>(begin: 10.0, end: 40.0).animate(_borderController);
  }

  @override
  void dispose() {
    if (mounted) {
      arriveController.stop();
    }
    arriveController.dispose();
    _controller.dispose();
    _borderController.dispose();
    super.dispose();
  }

  void popOverlay() => _controller.reverse()
    ..whenComplete(
      () {
        _overlayEntry.remove();
        setState(() {
          showText = true;
        });
      },
    );

  void _showOverlay(
    BuildContext context,
    ParentCubit pc,
  ) {
    RenderBox? renderBox = gKey.currentContext?.findRenderObject() as RenderBox?;
    Offset position = const Offset(0, 0);
    if (renderBox != null) {
      position = renderBox.localToGlobal(Offset.zero);
    }
    _overlayEntry = OverlayEntry(
      builder: (context) => AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          bool type = _animation.value < 0.6 ? true : false;
          return Positioned(
            top: type
                ? position.dy - MediaQuery.of(context).size.height * _animation.value
                : 0,
            child: Container(
              color: GeminiTheme.widgetAccentColor.withOpacity(_animation.value),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * _animation.value,
                  decoration: BoxDecoration(
                    color: GeminiTheme.widgetAccentColor,
                    borderRadius: BorderRadius.circular(10 * (1 - _animation.value)),
                  ),
                  child: SafeArea(
                    child: SubGoalOverlay(
                      supplyStop: widget.supplyStop,
                      popOverlay: () => popOverlay(),
                      destinationKey: widget.destinationKey,
                      pc: pc,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
    Overlay.of(context).insert(_overlayEntry);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final pc = context.read<ParentCubit>();
    if (mounted) {
      if (arriveController.status == AnimationStatus.completed &&
          !widget.supplyStop.arrived) {
        arriveController.reverse();
      } else if (arriveController.status == AnimationStatus.dismissed &&
          widget.supplyStop.arrived) {
        arriveController.forward();
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTapDown: (_) {
            _borderController.forward();
            setState(() {
              showText = false;
            });
          },
          onTapUp: (_) {
            _borderController.reverse().whenComplete(() {
              _showOverlay(context, pc);
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: AnimatedBuilder(
              animation: _borderAnimation,
              builder: (context, _) {
                return Container(
                  key: gKey,
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.75,
                  decoration: BoxDecoration(
                    color: GeminiTheme.widgetAccentColor,
                    borderRadius: BorderRadius.circular(_borderAnimation.value),
                  ),
                  child: showText
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4,
                          ),
                          child: Text(
                            widget.supplyStop.title,
                            style: GeminiTheme.bodyText,
                          ),
                        )
                      : const SizedBox.shrink(),
                );
              },
            ),
          ),
        ),
        const Spacer(),
        const Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Icon(
            Icons.circle_outlined,
            size: 30,
          ),
        ),
      ],
    );
  }
}

class SubGoalOverlay extends StatefulWidget {
  final SupplyStop supplyStop;
  final String destinationKey;
  final Function() popOverlay;
  final ParentCubit pc;
  const SubGoalOverlay({
    super.key,
    required this.supplyStop,
    required this.destinationKey,
    required this.popOverlay,
    required this.pc,
  });

  @override
  State<SubGoalOverlay> createState() => _SubGoalOverlayState();
}

class _SubGoalOverlayState extends State<SubGoalOverlay> {
  String aiResponse = "";
  @override
  Widget build(BuildContext context) {
    // Access your API key as an environment variable (see "Set up your API key" above)
    const apiKey = String.fromEnvironment('API_KEY');
    // final apiKey = Platform.environment['API_KEY'];

    if (apiKey.isEmpty) {
      print('API_KEY is not set');
      exit(1);
    }

// The Gemini 1.5 models are versatile and work with both text-only and multimodal prompts
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
    List<Part> destinations = [];
    for (final destination in widget.pc.state.destinations[widget.destinationKey]!) {
      destinations.add(
        TextPart(destination.title),
      );
      destinations.add(
        TextPart('${destination.arrived}'),
      );
    }
    return Material(
      color: GeminiTheme.widgetAccentColor,
      child: Padding(
        padding: const EdgeInsets.only(right: 38),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.0),
                  child: Icon(
                    FontAwesomeIcons.sailboat,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    widget.supplyStop.title,
                    style: GeminiTheme.subtitle,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => widget.popOverlay(),
                  child: const Padding(
                    padding: EdgeInsets.all(
                      8.0,
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: FormattedGeminiResponse(
                        responseText: aiResponse,
                      ),
                    ),
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     border: Border.all(
                  //       color: GeminiTheme.widgetColor,
                  //       width: 2,
                  //     ),
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  // ),
                  Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 38,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                print('working...');
                                final goals = TextPart(
                                  '{"type": "subGoal", "goal": "${widget.supplyStop.title}", "description": "${widget.supplyStop.description}"}',
                                );
                                final content = [
                                  Content.multi(
                                    [
                                      TextPart(instruction),
                                      TextPart('${widget.destinationKey} Goals'),
                                      ...destinations,
                                      TextPart('sub goals'),
                                      goals,
                                    ],
                                  ),
                                ];
                                final response = await model.generateContent(content);
                                setState(() {
                                  aiResponse = response.text ?? "";
                                });
                                // print(response.text);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: GeminiTheme.widgetColor,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Icon(
                                    Icons.assessment,
                                    color: GeminiTheme.iconColor,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: GeminiTheme.widgetColor,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.chat,
                                  color: GeminiTheme.iconColor,
                                  size: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FormattedGeminiResponse extends StatelessWidget {
  final String responseText;

  FormattedGeminiResponse({required this.responseText});

  @override
  Widget build(BuildContext context) {
    final formattedText = _formatResponseText(responseText);
    return RichText(text: formattedText);
  }

  TextSpan _formatResponseText(String text) {
    final spans = <TextSpan>[];
    final lines = text.split('\n');

    for (final line in lines) {
      if (line.startsWith('### ')) {
        // Header
        spans.add(TextSpan(
          text: line.substring(4) + '\n',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ));
      } else if (line.startsWith('## ')) {
        spans.add(TextSpan(
          text: line.substring(3) + '\n',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ));
      } else {
        // Regular text with bold formatting
        final words = line.split(' ');
        for (final word in words) {
          if (word.startsWith('**') && word.endsWith('**')) {
            // Bold word
            spans.add(TextSpan(
              text: word.substring(2, word.length - 2) + ' ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ));
          } else {
            // Normal word
            spans.add(TextSpan(text: word + ' '));
          }
        }
        spans.add(TextSpan(text: '\n')); // Add newline after each line
      }
    }

    return TextSpan(children: spans);
  }
}

const String instruction = """
Can you assess my goals? Here are my instructions:
I will first pass a list of my yearly goals. You will get all of them along with the header which contains the year.
You will then receive a list of the yearly goals.
After that you are going to receive a sub goal. Analyze it in relation to the yearly goals and assess if it is a good goal or not.
A good goal is something that is clearly defined and achievable. Look at todays date and the date of the yearly goals and assess timeliness. 
Assess whether or not the goal is relevant to the yearly goals.
Along with your thoughts, can you give me a scoring response in a specific format? Please include the '///' so I can parse it.
/// GoalOverallScore: int<1-3>, GoalRelevanceScore: int<1-3>, GoalTimelinessScore: int<1-3> ///
""";

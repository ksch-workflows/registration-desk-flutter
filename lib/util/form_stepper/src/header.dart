import "package:flutter/material.dart";

import "bubbles.dart";

class Header extends StatelessWidget {
  final List<String> stepTitles;
  final int currentStep;

  const Header({@required this.stepTitles, @required this.currentStep}) : assert(stepTitles != null);

  @override
  Widget build(BuildContext context) {
    final stepTitleWidgets = <Widget>[];
    for (var i = 0; i < stepTitles.length; i++) {
      final Widget stepTitleWidget = Row(
        children: [
          i == currentStep ? ActiveIndexBubble(i) : InactiveIndexBubble(i),
          Text(stepTitles[i], style: i == currentStep ? const TextStyle(fontWeight: FontWeight.bold) : null),
        ],
      );
      stepTitleWidgets.add(stepTitleWidget);
    }

    return Column(
      children: [
        Row(children: [
          const SizedBox(width: 15),
          ...stepTitleWidgets,
        ]),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
        ),
      ],
    );
  }
}
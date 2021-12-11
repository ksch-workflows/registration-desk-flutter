import 'package:flutter/material.dart';

import 'action_buttons.dart';
import 'header.dart';
import 'util.dart';

/// References
/// - https://material.io/archive/guidelines/components/steppers.html#
/// - https://flutter.dev/docs/cookbook/forms
class FormStepper extends StatefulWidget {
  final List<FormStep> steps;
  final Function onCancel;
  final Function onSave;

  const FormStepper({
    required this.steps,
    required this.onCancel,
    required this.onSave,
  });

  @override
  _FormStepperState createState() => _FormStepperState();
}

class _FormStepperState extends State<FormStepper> {
  late int currentIndex;
  late FormStep currentStep;

  _FormStepperState({int initialStepIndex = 0}) {
    currentIndex = initialStepIndex;
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.steps[currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Header(
          stepTitles: widget.steps.map((s) => s.title).toList(),
          currentStep: currentIndex,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 30, 25, 20),
              child: widget.steps[currentIndex].body,
            ),
          ),
        ),
        ActionButtons(
          onBack: onBack,
          onCancel: onCancel,
          onContinue: onContinue,
          isFirstStep: isFirstStep(),
          isLastStep: isLastStep(),
        ),
      ],
    );
  }

  bool isFirstStep() => currentIndex == 0;

  bool isLastStep() => currentIndex == widget.steps.length - 1;

  void onBack() {
    if (!currentStep.validate()) {
      return;
    }
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        currentStep = widget.steps[currentIndex];
      });
    }
  }

  void onCancel() {
    widget.onCancel();
  }

  void onContinue() {
    if (!currentStep.validate()) {
      return;
    }
    if (isLastStep()) {
      widget.onSave();
    } else {
      setState(() {
        currentIndex++;
        currentStep = widget.steps[currentIndex];
      });
    }
  }
}

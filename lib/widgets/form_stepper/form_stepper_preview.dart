import 'package:flutter/material.dart';

import '../test_bench.dart';
import 'form_stepper.dart';

void main() {
  runApp(
    TestBench(
      child: ExampleStepper(),
    ),
  );
}

class ExampleStepper extends StatefulWidget {
  final TextEditingController firstStepInputController =
      TextEditingController();
  final TextEditingController secondStepInputController =
      TextEditingController();
  final TextEditingController thirdStepInputController =
      TextEditingController();

  final Function? onCancel;

  ExampleStepper({this.onCancel});

  @override
  _ExampleStepperState createState() => _ExampleStepperState();
}

class _ExampleStepperState extends State<ExampleStepper> {
  List<FormStep> steps = [];

  @override
  void initState() {
    super.initState();

    steps = [
      _FirstStep(widget.firstStepInputController),
      _SecondStep(widget.secondStepInputController),
      _ThirdStep(widget.thirdStepInputController),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var onCancel = widget.onCancel != null ? widget.onCancel! : () => {};
    return FormStepper(steps: steps, onCancel: onCancel, onSave: () => {});
  }
}

class _FirstStep implements FormStep {
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstStepInputController;

  _FirstStep(this.firstStepInputController);

  @override
  Widget get body {
    return Form(
      key: formKey,
      child: TextFormField(
        key: const ValueKey('firstStepInput'),
        controller: firstStepInputController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'The input for the first step is mandatory.';
          }
          return null;
        },
      ),
    );
  }

  @override
  String get title => 'First step';

  @override
  bool validate() => formKey.currentState!.validate();
}

class _SecondStep implements FormStep {
  final formKey = GlobalKey<FormState>();
  final TextEditingController secondStepInputController;

  _SecondStep(this.secondStepInputController);

  @override
  Widget get body {
    return Form(
      key: formKey,
      child: TextFormField(
        key: const ValueKey('secondStepInput'),
        controller: secondStepInputController,
      ),
    );
  }

  @override
  String get title => 'Second step';

  @override
  bool validate() => true;
}

class _ThirdStep implements FormStep {
  final formKey = GlobalKey<FormState>();
  final TextEditingController thirdStepInputController;

  _ThirdStep(this.thirdStepInputController);

  @override
  Widget get body {
    return Form(
      key: formKey,
      child: TextFormField(
        key: const ValueKey('thirdStepInput'),
        controller: thirdStepInputController,
      ),
    );
  }

  @override
  String get title => 'Third step';

  @override
  bool validate() => true;
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:registration_desk/util/test_bench.dart';

import 'form_stepper_example.dart';

void main() {
  testWidgets('Should allow to enter text for the first step', (tester) async {
    var exampleStepper = ExampleStepper();
    await tester.open(exampleStepper);

    await tester.enterText(find.byKey(const ValueKey('firstStepInput')), 'John Doe');
    await tester.pump();

    expect(exampleStepper.firstStepInputController.text, equals('John Doe'));
  });

  testWidgets('Should go to next step', (tester) async {
    await tester.open(ExampleStepper());
    await tester.enterText(find.byKey(const ValueKey('firstStepInput')), 'John Doe');

    await goToNextStep(tester);

    expectOnSecondPage(tester);
  });

  testWidgets('Should go to previous step', (tester) async {
    await tester.open(ExampleStepper());
    await tester.enterText(find.byKey(const ValueKey('firstStepInput')), 'John Doe');
    await goToNextStep(tester);
    expectOnSecondPage(tester);

    await goToPreviousStep(tester);

    expectOnFirstPage(tester);
  });

  testWidgets('Should cancel stepper', (tester) async {
    var canceledHasBeenCalled = false;
    await tester.open(ExampleStepper(
      onCancel: () => canceledHasBeenCalled = true,
    ));

    var button = find.byKey(const ValueKey('cancelButton'));
    await tester.tap(button);

    expect(canceledHasBeenCalled, isTrue);
  });

  testWidgets('Should validate form before going to the next step', (tester) async {
    await tester.open(ExampleStepper());
    await tester.enterText(find.byKey(const ValueKey('firstStepInput')), '');

    await goToNextStep(tester);

    expect(find.text('The input for the first step is mandatory.'), findsOneWidget);
  });
}


Future goToNextStep(WidgetTester tester) async {
  var continueButton = find.byKey(const ValueKey('continueButton'));
  expect(continueButton, findsOneWidget);

  await tester.tap(continueButton);
  await tester.pump();
}

Future goToPreviousStep(WidgetTester tester) async {
  var button = find.byKey(const ValueKey('backButton'));
  expect(button, findsOneWidget);

  await tester.tap(button);
  await tester.pump();
}

void expectOnFirstPage(WidgetTester tester) {
  var inputField = find.byKey(const ValueKey('firstStepInput'));
  expect(inputField, findsOneWidget);

  var secondStepInputField = find.byKey(const ValueKey('secondStepInput'));
  expect(secondStepInputField, findsNothing);
}

void expectOnSecondPage(WidgetTester tester) {
  var inputField = find.byKey(const ValueKey('secondStepInput'));
  tester.verify(inputField, findsOneWidget);

  var firstStepInputField = find.byKey(const ValueKey('firstStepInput'));
  tester.verify(firstStepInputField, findsNothing);
}

extension WidgetTesterExtensions on WidgetTester {
  Future open(Widget widgetUnderTest) async {
    binding.window.textScaleFactorTestValue = 0.2; // Workaround to avoid pixel overflow errors
    return pumpWidget(TestBench(
      child: widgetUnderTest,
    ));
  }

  void printStringValueKeys() {
    print('══╡ CURRENT STRING VALUE KEYS ╞═════════════════════════════════════════════════════════════════════');
    allWidgets
        .map((widget) => widget.key)
        .whereType<ValueKey>()
        .map((key) => key.value)
        .whereType<String>()
        .toList()
        .forEach(print);
  }

  void verify(
    dynamic actual,
    dynamic matcher, {
    String? reason,
    dynamic skip, // true or a String
  }) {
    try {
      expect(actual, matcher, reason: reason, skip: skip);
    } on TestFailure catch (_) {
      printStringValueKeys();
      rethrow;
    }
  }
}

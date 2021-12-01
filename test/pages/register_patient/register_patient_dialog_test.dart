// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:registration_desk/context.dart';
import 'package:registration_desk/pages/register_patient/index.dart';
import 'package:registration_desk/widgets/test_bench.dart';

void main() {
  setUpAll(initialiseInMemoryContext);

  testWidgets('Should open patient details after registration wizard',
      (tester) async {
    tester.binding.window.textScaleFactorTestValue = 0.2;

    // Open "Register patient" page
    var widget = RegisterPatientPage();
    await tester.pumpWidget(TestBench(
      child: widget,
    ));

    // Open "Register patient" wizard
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Enter personal data
    await tester.enterText(
      find.byKey(const ValueKey('patientNameInput')),
      'John Doe',
    );
    await tester.tap(find.byKey(const ValueKey('continueButton')));
    await tester.pumpAndSettle();

    // Skip contact information
    await tester.tap(find.byKey(const ValueKey('continueButton')));
    await tester.pumpAndSettle();

    // Use default visit type
    await tester.tap(find.byKey(const ValueKey('continueButton')));
    await tester.pumpAndSettle();

    // Verify that the patient details page has been opened
    var pageNameWidget =
        find.byKey(const ValueKey('pageName')).evaluate().single.widget as Text;
    expect(pageNameWidget.data, equals('Patient details'));
  });
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:registration_desk/api/patient/patient.dart';
import 'package:registration_desk/pages/register_patient/register_patient_page.dart';
import 'package:registration_desk/utils/test_bench/dummy_context.dart';
import 'package:registration_desk/widgets/test_bench.dart';
import 'package:uuid/uuid.dart';

void main() {
  late DummyAppContext ctx;

  setUp(() {
    ctx = DummyAppContext()..init();
  });

  tearDown(() async {
    await GetIt.I.reset();
  });

  testWidgets('Should open patient details after registration wizard',
      (tester) async {
    tester.binding.window.textScaleFactorTestValue = 0.2;
    ctx.patientService.patientResponse = Patient(
      id: const Uuid().v4(),
      opdNumber: null,
      name: 'Janie Doe',
      fatherName: 'John Doe',
      location: null,
      gender: null,
      currentVisit: null,
      lastVisit: null,
      category: null,
    );

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

    // Verify that the visits tab has been opened
    expect(find.text('Current visit'), findsOneWidget);
  });

  testWidgets('Should allow to cancel patient registration', (tester) async {
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

    // Cancel registration
    await tester.tap(find.byKey(const ValueKey('cancelButton')));
    await tester.pumpAndSettle();

    // Re-open "Register patient" wizard
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Check that patient name is not present
    expect(find.text('John Doe'), findsNothing);
  });
}

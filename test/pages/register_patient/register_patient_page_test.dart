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

  testWidgets('Should show search results', (tester) async {
    tester.binding.window.textScaleFactorTestValue = 0.2;
    ctx.patientService.patientsResponse = [
      Patient(
        id: const Uuid().v4(),
        opdNumber: null,
        name: 'John Doe',
        fatherName: null,
        location: null,
        gender: null,
        currentVisit: null,
        lastVisit: null,
        category: null,
      )
    ];

    await tester.pumpWidget(TestBench(
      child: RegisterPatientPage(),
    ));
    var patientSearchInputField = find.byType(TextField);

    await tester.enterText(patientSearchInputField, 'John');
    await tester.pump();

    expect(find.byType(DataTable), findsOneWidget);
  });

  testWidgets('Should not show search result table before the search',
      (tester) async {
    tester.binding.window.textScaleFactorTestValue = 0.2;

    await tester.pumpWidget(TestBench(
      child: RegisterPatientPage(),
      pageSize: const Size(800, 600),
    ));

    expect(find.byType(DataTable), findsNothing);
  });

  testWidgets('Should show message about no search results', (tester) async {
    tester.binding.window.textScaleFactorTestValue = 0.2;
    ctx.patientService.patientsResponse = [];

    await tester.pumpWidget(TestBench(
      child: RegisterPatientPage(),
      pageSize: const Size(800, 600),
    ));

    var patientSearchInputField = find.byType(TextField);
    await tester.enterText(patientSearchInputField, 'xxxxxxx');
    await tester.pump();

    expect(find.text('No patients found.'), findsOneWidget);
  });

  testWidgets('Should go to patient details of search result', (tester) async {
    tester.binding.window.textScaleFactorTestValue = 0.2;
    final patient = Patient(
      id: const Uuid().v4(),
      name: 'Janie Doe',
      fatherName: 'John Doe',
      location: 'Guesthouse',
      gender: 'Female',
      currentVisit: null,
      category: null,
      opdNumber: null,
      lastVisit: null,
    );
    ctx.patientService.patientsResponse = [patient];
    ctx.patientService.patientResponse = patient;

    await tester.pumpWidget(TestBench(
      child: RegisterPatientPage(),
      pageSize: const Size(800, 600),
    ));

    var patientSearchInputField = find.byType(TextField);
    await tester.enterText(patientSearchInputField, 'Janie Doe');
    await tester.pump();

    await tester.tap(find.byKey(ValueKey(patient.id!)));
    await tester.pumpAndSettle();

    // Verify that the patient details page has been opened
    var pageNameWidget =
        find.byKey(const ValueKey('pageName')).evaluate().single.widget as Text;
    expect(pageNameWidget.data, equals('Patient details'));
  });
}

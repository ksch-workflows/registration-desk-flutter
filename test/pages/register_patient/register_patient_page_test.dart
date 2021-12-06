import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:registration_desk/api/patient/patient.dart';
import 'package:registration_desk/api/patient/patient_service.dart';
import 'package:registration_desk/api/visit/visit_service.dart';
import 'package:registration_desk/context.dart';
import 'package:registration_desk/pages/register_patient/index.dart';
import 'package:registration_desk/utils/test_bench/mock_patient_service.dart';
import 'package:registration_desk/utils/test_bench/mock_visit_service.dart';
import 'package:registration_desk/widgets/test_bench.dart';
import 'package:uuid/uuid.dart';

void main() {
  late MockPatientService mockPatientService;
  late MockVisitService mockVisitService;

  setUp(() {
    mockPatientService = MockPatientService();
    GetIt.I.registerSingleton<PatientService>(mockPatientService);

    mockVisitService = MockVisitService();
    GetIt.I.registerSingleton<VisitService>(mockVisitService);
  });

  tearDown(() {
    GetIt.I.reset();
  });

  testWidgets('Should show search results', (tester) async {
    tester.binding.window.textScaleFactorTestValue = 0.2;
    mockPatientService.patientsResponse = [
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
    mockPatientService.patientsResponse = [];

    await tester.pumpWidget(TestBench(
      child: RegisterPatientPage(),
      pageSize: const Size(800, 600),
    ));

    var patientSearchInputField = find.byType(TextField);
    await tester.enterText(patientSearchInputField, 'xxxxxxx');
    await tester.pump();

    expect(find.text('No patients found.'), findsOneWidget);
  });
}

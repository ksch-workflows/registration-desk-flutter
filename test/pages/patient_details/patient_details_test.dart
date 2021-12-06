// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:registration_desk/api/patient/patient.dart';
import 'package:registration_desk/api/patient/patient_service.dart';
import 'package:registration_desk/api/visit/visit_service.dart';
import 'package:registration_desk/pages/patient_details/index.dart';
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

  testWidgets('Should render patient details widget', (tester) async {
    tester.binding.window.textScaleFactorTestValue = 0.2;
    mockPatientService.patientResponse = Patient(
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

    await tester.pumpWidget(
      TestBench(
        child: PatientDetailsPage(mockPatientService.patientResponse.id!),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Janie Doe'), findsWidgets);
  });
}

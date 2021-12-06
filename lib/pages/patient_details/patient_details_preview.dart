import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ksch_dart_client/resources.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

import '../../api/patient/patient.dart';
import '../../api/patient/patient_service.dart';
import '../../api/visit/visit.dart';
import '../../api/visit/visit_service.dart';
import '../../utils/test_bench/mock_patient_service.dart';
import '../../utils/test_bench/mock_visit_service.dart';
import '../../widgets/test_bench.dart';
import 'index.dart';

String setupMockPatient({int fetchDelayInSec = 1}) {
  final patientService = MockPatientService();
  final visitService = MockVisitService();

  final patient = Patient(
    id: const Uuid().v4(),
    name: 'Janie Doe',
    fatherName: 'John Doe',
    location: 'Guesthouse',
    gender: 'Female',
    currentVisit: const Uuid().v4(),
    category: null,
    opdNumber: null,
    lastVisit: null,
  );

  final visit = Visit(
    id: const Uuid().v4(),
    type: VisitType.OPD,
  );

  when(() => patientService.get(any())).thenAnswer(
    (_) => Future.delayed(
      Duration(seconds: fetchDelayInSec),
      () => patient,
    ),
  );
  when(
    () => visitService.get(
      patientId: any(named: 'patientId'),
      visitId: any(named: 'visitId'),
    ),
  ).thenAnswer((_) => Future.delayed(const Duration(seconds: 0), () => visit));

  GetIt.I.registerSingleton<PatientService>(patientService);
  GetIt.I.registerSingleton<VisitService>(visitService);

  return patient.id!;
}

void main() {
  final patientId = setupMockPatient();

  runApp(
    TestBench(
      child: PatientDetailsPage(patientId),
    ),
  );
}

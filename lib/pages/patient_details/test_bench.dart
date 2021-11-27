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

void main() {
  final patientService = MockPatientService();
  final visitService = MockVisitService();

  final patient = Patient(
    id: const Uuid().v4(),
    name: 'Janie Doe',
    fatherName: 'John Doe',
    location: 'Guesthouse',
    gender: 'Female',
    currentVisit: const Uuid().v4(),
  );

  final visit = Visit(
    id: const Uuid().v4(),
    type: VisitType.OPD,
  );

  when(() => patientService.get(any())).thenAnswer(
    (_) => Future.delayed(const Duration(seconds: 1), () => patient),
  );
  when(
    () => visitService.get(
      patientId: any(named: 'patientId'),
      visitId: any(named: 'visitId'),
    ),
  ).thenAnswer((_) => Future.delayed(const Duration(seconds: 0), () => visit));

  GetIt.I.registerSingleton<PatientService>(patientService);
  GetIt.I.registerSingleton<VisitService>(visitService);

  runApp(
    TestBench(
      child: PatientDetailsPage(patient.id!),
    ),
  );
}

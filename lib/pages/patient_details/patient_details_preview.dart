import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ksch_dart_client/resources.dart';
import 'package:uuid/uuid.dart';

import '../../api/patient/patient.dart';
import '../../api/patient/patient_service.dart';
import '../../api/visit/visit.dart';
import '../../api/visit/visit_service.dart';
import '../../utils/test_bench/dummy_patient_service.dart';
import '../../utils/test_bench/dummy_visit_service.dart';
import '../../widgets/test_bench.dart';
import 'index.dart';

String setupMockPatient({int fetchDelayInSec = 1}) {
  final patientService = DummyPatientService();
  final visitService = DummyVisitService();

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
  patientService.patientResponse = patient;
  patientService.delay = Duration(seconds: fetchDelayInSec);

  visitService.startVisit(patient.id!, VisitType.OPD);

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

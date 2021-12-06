import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

import '../../api/patient/patient.dart';
import '../../api/patient/patient_service.dart';
import '../../api/visit/visit_service.dart';
import '../../utils/test_bench/mock_patient_service.dart';
import '../../utils/test_bench/mock_visit_service.dart';
import '../../widgets/test_bench.dart';
import 'index.dart';

void main() {
  var patientService = MockPatientService();
  patientService.patientResponse = Patient(
    id: const Uuid().v4(),
    gender: null,
    fatherName: null,
    lastVisit: null,
    currentVisit: null,
    opdNumber: null,
    category: null,
    location: null,
    name: null,
  );

  var visitService = MockVisitService();

  GetIt.I.registerSingleton<PatientService>(patientService);
  GetIt.I.registerSingleton<VisitService>(visitService);

  runApp(
    TestBench(
      child: RegisterPatientPage(),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../api/patient/patient_service.dart';
import '../../api/visit/visit_service.dart';
import '../../utils/test_bench/dummy_patient_service.dart';
import '../../utils/test_bench/dummy_visit_service.dart';
import '../../widgets/test_bench.dart';
import 'index.dart';

void main() {
  var patientService = DummyPatientService();
  var visitService = DummyVisitService();

  GetIt.I.registerSingleton<PatientService>(patientService);
  GetIt.I.registerSingleton<VisitService>(visitService);

  runApp(
    TestBench(
      child: RegisterPatientPage(),
    ),
  );
}

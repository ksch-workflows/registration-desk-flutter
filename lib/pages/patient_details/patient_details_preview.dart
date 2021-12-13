import 'package:flutter/material.dart';
import 'package:ksch_dart_client/resources.dart';
import 'package:uuid/uuid.dart';

import '../../api/patient/patient.dart';
import '../../utils/test_bench/dummy_context.dart';
import '../../widgets/test_bench.dart';
import 'index.dart';

void main() {
  var patient = Patient(
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
  var ctx = DummyAppContext()..init();
  ctx.patientService.patientResponse = patient;
  ctx.patientService.delay = const Duration(seconds: 2);
  ctx.visitService.startVisit(patient.id!, VisitType.OPD);

  runApp(
    TestBench(
      child: PatientDetailsPage(patient.id!),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../api/patient/patient.dart';
import '../../utils/test_bench/dummy_context.dart';
import '../../widgets/test_bench.dart';
import 'register_patient_page.dart';

void main() {
  final ctx = DummyAppContext()..init();

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

  runApp(
    TestBench(
      child: RegisterPatientPage(),
    ),
  );
}

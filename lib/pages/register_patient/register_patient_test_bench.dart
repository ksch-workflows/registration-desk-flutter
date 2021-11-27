import 'package:flutter/material.dart';

import '../../context.dart';
import '../../widgets/test_bench.dart';
import 'register_patient.dart';

void main() {
  initialiseInMemoryContext();

  runApp(
    TestBench(
      child: RegisterPatientPage(),
    ),
  );
}

import 'package:flutter/material.dart';

import '../../context.dart';
import '../../widgets/test_bench.dart';
import 'index.dart';

void main() {
  initialiseMockContext();

  runApp(
    TestBench(
      child: RegisterPatientPage(),
      isFullPage: true,
    ),
  );
}

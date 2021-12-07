import 'package:flutter/material.dart';

import '../../utils/test_bench/dummy_context.dart';
import '../../widgets/test_bench.dart';
import 'index.dart';

void main() {
  DummyContext()..init();

  runApp(
    TestBench(
      child: RegisterPatientPage(),
    ),
  );
}

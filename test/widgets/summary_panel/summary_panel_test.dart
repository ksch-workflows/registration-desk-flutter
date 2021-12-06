import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:registration_desk/api/patient/patient_service.dart';
import 'package:registration_desk/api/visit/visit_service.dart';
import 'package:registration_desk/context.dart';
import 'package:registration_desk/utils/test_bench/mock_patient_service.dart';
import 'package:registration_desk/utils/test_bench/mock_visit_service.dart';
import 'package:registration_desk/widgets/test_bench.dart';

void main() {
  late MockPatientService mockPatientService;
  late MockVisitService mockVisitService;

  setUp(() {
    mockPatientService = MockPatientService();
    GetIt.I.registerSingleton<PatientService>(mockPatientService);

    mockVisitService = MockVisitService();
    GetIt.I.registerSingleton<VisitService>(mockVisitService);
  });

  tearDown(() {
    GetIt.I.reset();
  });

  testWidgets('Should render widget', (tester) async {
    tester.binding.window.textScaleFactorTestValue = 0.2;

    await tester.pumpWidget(const TestBench(
      child: Text('Hello, Widget!'),
      pageSize: Size(800, 600),
    ));

    expect(find.byType(Text), findsWidgets);
  });
}

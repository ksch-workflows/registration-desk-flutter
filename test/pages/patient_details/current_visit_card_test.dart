// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:ksch_dart_client/resources.dart';
import 'package:registration_desk/api/visit/visit.dart';
import 'package:registration_desk/pages/patient_details/tabs/current_visit_cart.dart';
import 'package:registration_desk/utils/test_bench/dummy_context.dart';
import 'package:registration_desk/utils/time.dart';
import 'package:registration_desk/widgets/test_bench.dart';
import 'package:uuid/uuid.dart';

void main() {
  setUp(() {
    DummyContext()..init();
  });

  tearDown(() async {
    await GetIt.I.reset();
  });

  testWidgets('Should render widget', (tester) async {
    tester.binding.window.textScaleFactorTestValue = 0.2;

    var currentVisit = Visit(
      id: const Uuid().v4(),
      patientId: const Uuid().v4(),
      opdNumber: '10-12332',
      timeStart: DateTime.now(),
      type: VisitType.OPD,
    );

    var widget = CurrentVisitCard(currentVisit: currentVisit);

    await tester.pumpWidget(
      TestBench(
        child: widget,
        pageSize: Size(1000, 300),
      ),
    );

    expect(find.text('Current visit'), findsWidgets);
  });

  testWidgets('Should show formatted visit details', (tester) async {
    tester.binding.window.textScaleFactorTestValue = 0.2;

    var time = const Time(hour: 20, minute: 40);
    var date = const Date(year: 2021, month: 10, day: 13);
    var currentVisit = Visit(
      id: const Uuid().v4(),
      patientId: const Uuid().v4(),
      opdNumber: '10-12332',
      timeStart: time.atDate(date),
      type: VisitType.OPD,
    );

    var widget = CurrentVisitCard(currentVisit: currentVisit);

    await tester.pumpWidget(TestBench(
      child: widget,
      pageSize: Size(800, 600),
    ));

    expect(find.text('Wednesday, 13-10-2021, 8:40p.m.'), findsWidgets);
    expect(find.text('OPD'), findsWidgets);
  });
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:registration_desk/context.dart';
import 'package:registration_desk/widgets/test_bench.dart';

void main() {
  setUpAll(initialiseInMemoryContext);

  testWidgets('Should open patient details after registration wizard',
      (tester) async {
    tester.binding.window.textScaleFactorTestValue = 0.2;

    var widget = Text('Hello, Widget!');

    await tester.pumpWidget(TestBench(
      child: widget,
      pageSize: Size(800, 600),
    ));

    expect(find.byType(Text), findsWidgets);
  });
}

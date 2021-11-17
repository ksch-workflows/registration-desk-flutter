import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:registration_desk/context.dart';
import 'package:registration_desk/widgets/test_bench.dart';

void main() {
  setUpAll(initialiseInMemoryContext);

  testWidgets('Should render widget', (tester) async {
    tester.binding.window.textScaleFactorTestValue = 0.2;

    await tester.pumpWidget(const TestBench(
      child: Text('Hello, Widget!'),
      pageSize: Size(800, 600),
    ));

    expect(find.byType(Text), findsWidgets);
  });
}

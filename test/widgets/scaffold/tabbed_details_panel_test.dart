// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:registration_desk/api/patient/patient.dart';
import 'package:registration_desk/widgets/scaffold/tabbed_details_panel.dart';
import 'package:registration_desk/widgets/test_bench.dart';
import 'package:uuid/uuid.dart';

final patient = Patient(
  id: const Uuid().v4(),
  name: 'Jonny Doe',
  fatherName: 'John Doe',
  gender: null,
  opdNumber: null,
  currentVisit: null,
  lastVisit: null,
  location: null,
  category: null,
);

void main() {
  testWidgets('Should render first tab by default', (tester) async {
    tester.binding.window.textScaleFactorTestValue = 0.2;

    var widget = TabbedDetailsPanel(
      patient: patient,
      tabs: const [
        SummaryPanelTab(title: 'Tab 1', child: Tab1()),
        SummaryPanelTab(title: 'Tab 2', child: Tab2()),
      ],
    );
    await tester.pumpWidget(TestBench(
      child: widget,
      pageSize: Size(800, 600),
    ));

    expect(find.text('Contents of tab 1.'), findsWidgets);
    expect(find.text('Contents of tab 2.'), findsNothing);
  });

  testWidgets('Should allow to start with second tab', (tester) async {
    tester.binding.window.textScaleFactorTestValue = 0.2;

    var widget = TabbedDetailsPanel(
      patient: patient,
      tabs: const [
        SummaryPanelTab(title: 'Tab 1', child: Tab1()),
        SummaryPanelTab(title: 'Tab 2', child: Tab2()),
      ],
      initialTabIndex: 1,
    );
    await tester.pumpWidget(TestBench(
      child: widget,
      pageSize: Size(800, 600),
    ));

    expect(find.text('Contents of tab 2.'), findsWidgets);
    expect(find.text('Contents of tab 1.'), findsNothing);
  });

  testWidgets('Should allow to switch tab', (tester) async {
    tester.binding.window.textScaleFactorTestValue = 0.2;

    var widget = TabbedDetailsPanel(
      patient: patient,
      tabs: const [
        SummaryPanelTab(title: 'Tab 1', child: Tab1()),
        SummaryPanelTab(title: 'Tab 2', child: Tab2()),
      ],
    );
    await tester.pumpWidget(TestBench(
      child: widget,
      pageSize: Size(800, 600),
    ));

    expect(find.text('Contents of tab 2.'), findsNothing);

    await tester.tap(
      find.descendant(
        of: find.byType(Tab),
        matching: find.text('Tab 2'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Contents of tab 2.'), findsWidgets);
  });
}

class Tab1 extends StatelessWidget {
  const Tab1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Contents of tab 1.'),
    );
  }
}

class Tab2 extends StatelessWidget {
  const Tab2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Contents of tab 2.'),
    );
  }
}

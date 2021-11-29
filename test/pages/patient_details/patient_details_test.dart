// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:registration_desk/pages/patient_details/patient_details.dart';
import 'package:registration_desk/pages/patient_details/patient_details_test_bench.dart';
import 'package:registration_desk/widgets/test_bench.dart';

void main() {
  testWidgets('Should render patient details widget', (tester) async {
    tester.binding.window.textScaleFactorTestValue = 0.2;

    // TODO: This approach does not work if there are multiple tests.
    // Maybe there can be an @After method which resets GetIt after every test.
    final patientId = setupMockPatient(fetchDelayInSec: 0);

    await tester.pumpWidget(
      TestBench(
        child: PatientDetailsPage(patientId),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Janie Doe'), findsWidgets);
  });
}

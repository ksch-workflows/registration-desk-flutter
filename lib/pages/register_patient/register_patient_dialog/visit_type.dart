
import 'package:flutter/material.dart';
import 'package:ksch_dart_client/resources.dart';

import '../../../widgets/form_stepper/form_stepper.dart';
import '../../../widgets/test_bench.dart';

class VisitTypeFormStep implements FormStep {
  final _formKey = GlobalKey<FormState>();
  final FormValue<VisitType>? visitTypeSelection;

  VisitTypeFormStep({this.visitTypeSelection});

  @override
  String get title => 'Visit type';

  @override
  bool validate() => true;

  @override
  Widget get body => _VisitTypeFormStepBody(
        formKey: _formKey,
        visitTypeSelection: visitTypeSelection,
      );
}

class _VisitTypeFormStepBody extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  final FormValue<VisitType>? visitTypeSelection;

  const _VisitTypeFormStepBody({this.formKey, this.visitTypeSelection});

  @override
  _VisitTypeFormStepBodyState createState() => _VisitTypeFormStepBodyState();
}

class _VisitTypeFormStepBodyState extends State<_VisitTypeFormStepBody> {
  FocusNode? initialFocus;
  late VisitType selectedVisitType;

  @override
  void initState() {
    super.initState();
    initialFocus = FocusNode();
    selectedVisitType = VisitType.EMERGENCY;
    widget.visitTypeSelection!.value = selectedVisitType;
  }

  @override
  void dispose() {
    super.dispose();
    initialFocus!.dispose();
  }

  void setSelectedVisitType(VisitType visitType) {
    setState(() {
      selectedVisitType = visitType;
      widget.visitTypeSelection!.value = visitType;
    });
  }

  @override
  Widget build(BuildContext context) {
    initialFocus!.requestFocus();
    return Column(
      children: [
        RadioListTile<VisitType>(
          value: VisitType.EMERGENCY,
          title: const Text('Emergency'),
          groupValue: selectedVisitType,
          onChanged: (value) {
            if (value != null) {
              setSelectedVisitType(value);
            }
          },
        ),
        RadioListTile<VisitType>(
          value: VisitType.OPD,
          title: const Text('OPD'),
          subtitle: const Text('Outpatient department'),
          groupValue: selectedVisitType,
          onChanged: (value) {
            if (value != null) {
              setSelectedVisitType(value);
            }
          },
        ),
        RadioListTile<VisitType>(
          value: VisitType.IPD,
          title: const Text('IPD'),
          subtitle: const Text('Inpatient department'),
          groupValue: selectedVisitType,
          onChanged: (value) {
            if (value != null) {
              setSelectedVisitType(value);
            }
          },
        ),
      ],
    );
  }
}

void main() {
  var contactInformationStep = VisitTypeFormStep(
    visitTypeSelection: FormValue<VisitType>(),
  );

  runApp(
    TestBench(
      child: contactInformationStep.body,
    ),
  );
}

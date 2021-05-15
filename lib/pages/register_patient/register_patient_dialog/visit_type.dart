import 'package:flutter/material.dart';

import '../../../widgets/form_stepper/form_stepper.dart';
import '../../../widgets/test_bench.dart';

class VisitTypeFormStep implements FormStep {
  final _formKey = GlobalKey<FormState>();
  final FormValue<String>? visitTypeSelection;

  VisitTypeFormStep({this.visitTypeSelection});

  @override
  String get title => 'Visit type';

  @override
  bool validate() => _formKey.currentState!.validate();

  @override
  Widget get body => _VisitTypeFormStepBody(
        formKey: _formKey,
        visitTypeSelection: visitTypeSelection,
      );
}

class _VisitTypeFormStepBody extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  final FormValue<String>? visitTypeSelection;

  const _VisitTypeFormStepBody({this.formKey, this.visitTypeSelection});

  @override
  _VisitTypeFormStepBodyState createState() => _VisitTypeFormStepBodyState();
}

class _VisitTypeFormStepBodyState extends State<_VisitTypeFormStepBody> {
  FocusNode? initialFocus;

  @override
  void initState() {
    super.initState();
    initialFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    initialFocus!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initialFocus!.requestFocus();
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _visitTypeSelector(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InputDecorator _visitTypeSelector() {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: widget.visitTypeSelection!.value != null ? 'Visit type' : null,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.only(left: 10),
      ),
      child: Container(
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            value: widget.visitTypeSelection!.value,
            focusNode: initialFocus,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            hint: const Text('Please select a visit type...'),
            onChanged: _handleVisitTypeSelectionChanged,
            items: _visitTypeOptions(),
            validator: _validateVisitTypeSelection,
          ),
        ),
      ),
    );
  }

  String? _validateVisitTypeSelection(value) {
    if (value == null || value.isEmpty) {
      return 'Please select a visit type';
    } else {
      return null;
    }
  }

  List<DropdownMenuItem<String>> _visitTypeOptions() {
    return <String>['OPD', 'IPD'].map<DropdownMenuItem<String>>((value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  void _handleVisitTypeSelectionChanged(newValue) {
    setState(() {
      widget.visitTypeSelection!.value = newValue;
    });
  }
}

void main() {
  var contactInformationStep = VisitTypeFormStep(visitTypeSelection: FormValue<String>());

  runApp(
    TestBench(
      child: contactInformationStep.body,
    ),
  );
}

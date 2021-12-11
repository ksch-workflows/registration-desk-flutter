import 'package:flutter/material.dart';
import 'package:ksch_dart_client/resources.dart';

import '../../../api/patient/patient.dart';
import '../../../widgets/form_stepper/form_stepper.dart';
import 'contact_information.dart';
import 'personal_data.dart';
import 'visit_type.dart';

class RegisterPatientResult {
  final Patient patient;
  final VisitType visitType;

  RegisterPatientResult({
    required this.patient,
    required this.visitType,
  });
}

class RegisterPatientDialog extends StatefulWidget {
  final Function onDialogClose;

  const RegisterPatientDialog({
    required this.onDialogClose,
  });

  @override
  State<StatefulWidget> createState() => _RegisterPatientDialogState();
}

class _RegisterPatientDialogState extends State<RegisterPatientDialog> {
  final visitTypeSelection = FormValue<VisitType>();
  final nameController = TextEditingController();
  final fatherNameController = TextEditingController();
  final locationController = TextEditingController();

  late List<FormStep> _steps;

  @override
  void dispose() {
    nameController.dispose();
    fatherNameController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _steps = [
      PersonalDataFormStep(
        nameController: nameController,
        fatherNameController: fatherNameController,
      ),
      ContactInformationFormStep(
        locationController: locationController,
      ),
      VisitTypeFormStep(
        visitTypeSelection: visitTypeSelection,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Register patient'),
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints.tight(const Size(800, 400)),
          child: FormStepper(
            steps: _steps,
            onCancel: cancel,
            onSave: save,
          ),
        ),
      ],
    );
  }

  void save() {
    final newPatient = Patient(
      name: nameController.text.notEmptyOrNull,
      fatherName: fatherNameController.text.notEmptyOrNull,
      location: locationController.text.notEmptyOrNull,
      category: null,
      id: null,
      currentVisit: null,
      lastVisit: null,
      gender: null,
      opdNumber: null,
    );
    final result = RegisterPatientResult(
      patient: newPatient,
      visitType: visitTypeSelection.value!,
    );
    widget.onDialogClose(result);
  }

  void cancel() {
    widget.onDialogClose(null);
  }
}

extension NotEmptyOrNull on String {
  String? get notEmptyOrNull {
    if (trim().isEmpty) {
      return null;
    } else {
      return this;
    }
  }
}

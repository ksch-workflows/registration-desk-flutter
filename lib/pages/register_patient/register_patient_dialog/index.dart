import 'package:flutter/material.dart';
import 'package:ksch_dart_client/resources.dart';

import '../../../api/patient/patient.dart';
import '../../../utils/singleton_bucket.dart';
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

class _RegisterPatientDialogModel {
  final visitTypeSelection = FormValue<VisitType>();
  final nameController = TextEditingController();
  final fatherNameController = TextEditingController();
  final locationController = TextEditingController();
}

class _RegisterPatientDialogState extends State<RegisterPatientDialog> {
  // FIXME Dispose is missing
  final _model = SingletonBucket.get(() => _RegisterPatientDialogModel());

  late List<FormStep> _steps;

  @override
  void initState() {
    super.initState();

    _steps = [
      PersonalDataFormStep(
        nameController: _model!.nameController,
        fatherNameController: _model!.fatherNameController,
      ),
      ContactInformationFormStep(
        locationController: _model!.locationController,
      ),
      VisitTypeFormStep(
        visitTypeSelection: _model!.visitTypeSelection,
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
      name: _notEmptyOrNull(_model!.nameController.text),
      fatherName: _notEmptyOrNull(_model!.fatherNameController.text),
      location: _notEmptyOrNull(_model!.locationController.text),
      category: null,
      id: null,
      currentVisit: null,
      lastVisit: null,
      gender: null,
      opdNumber: null,
    );
    final result = RegisterPatientResult(
      patient: newPatient,
      visitType: _model!.visitTypeSelection.value!,
    );
    // FIXME: This needs to trigger a disposal
    SingletonBucket.reset<_RegisterPatientDialogModel>();
    widget.onDialogClose(result);
  }

  String? _notEmptyOrNull(String value) {
    if (value.trim().isEmpty) {
      return null;
    } else {
      return value;
    }
  }

  void cancel() {
    SingletonBucket.reset<_RegisterPatientDialogModel>();
    widget.onDialogClose(null);
  }
}

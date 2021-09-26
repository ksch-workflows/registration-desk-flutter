import 'package:flutter/material.dart';

import '../../../api/patient/patient.dart';
import '../../../utils/singleton_bucket.dart';
import '../../../widgets/form_stepper/form_stepper.dart';
import 'contact_information.dart';
import 'personal_data.dart';
import 'visit_type.dart';

class RegisterPatientResult {
  final Patient patient;
  final String visitType;

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
  final visitTypeSelection = FormValue<String>();
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
      name: _model!.nameController.text,
      fatherName: _model!.fatherNameController.text,
      location: _model!.locationController.text,
    );
    final result = RegisterPatientResult(
      patient: newPatient,
      visitType: _model!.visitTypeSelection.value!,
    );

    SingletonBucket.reset<_RegisterPatientDialogModel>();
    widget.onDialogClose(result);
  }

  void cancel() {
    SingletonBucket.reset<_RegisterPatientDialogModel>();
    widget.onDialogClose(null);
  }
}

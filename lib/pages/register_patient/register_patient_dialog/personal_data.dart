import 'package:flutter/material.dart';

import '../../../util/form_stepper/form_stepper.dart';

class PersonalDataFormStep implements FormStep {
  final formKey = GlobalKey<FormState>();

  final TextEditingController? nameController;
  final TextEditingController? fatherNameController;

  PersonalDataFormStep({
    this.nameController,
    this.fatherNameController,
  });

  @override
  String get title => 'Personal data';

  @override
  Widget get body {
    return _PersonalDataForm(
      formKey: formKey,
      nameController: nameController,
      fatherNameController: fatherNameController,
    );
  }

  @override
  bool validate() => formKey.currentState!.validate();
}

class _PersonalDataForm extends StatefulWidget {
  const _PersonalDataForm({
    Key? key,
    required this.formKey,
    required this.nameController,
    required this.fatherNameController,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController? nameController;
  final TextEditingController? fatherNameController;

  @override
  _PersonalDataFormState createState() => _PersonalDataFormState();
}

class _PersonalDataFormState extends State<_PersonalDataForm> {
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
      child: Column(children: <Widget>[
        TextFormField(
          controller: widget.nameController,
          focusNode: initialFocus,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "The patient's name is required information.";
            }
            return null;
          },
          decoration: const InputDecoration(
              labelText: "Patient's name*",
              border: OutlineInputBorder(),
              hintText: "Please enter the patient's name",
              helperText: '* Required'),
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
          controller: widget.fatherNameController,
          decoration: const InputDecoration(
            labelText: "Father's name",
            border: OutlineInputBorder(),
            hintText: "Please enter the patient father's name, if applicable",
          ),
        ),
      ]),
    );
  }
}

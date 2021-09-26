import 'package:flutter/material.dart';

import '../../../widgets/form_stepper/form_stepper.dart';

class ContactInformationFormStep implements FormStep {
  final formKey = GlobalKey<FormState>();

  final TextEditingController? locationController;

  ContactInformationFormStep({this.locationController});

  @override
  String get title => 'Contact information';

  @override
  Widget get body {
    return _ContactInformationForm(
      formKey: formKey,
      locationController: locationController,
    );
  }

  @override
  bool validate() => formKey.currentState!.validate();
}

class _ContactInformationForm extends StatefulWidget {
  const _ContactInformationForm({
    required this.formKey,
    required this.locationController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController? locationController;

  @override
  _ContactInformationFormState createState() => _ContactInformationFormState();
}

class _ContactInformationFormState extends State<_ContactInformationForm> {
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
          controller: widget.locationController,
          focusNode: initialFocus,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "The patient's location is required information.";
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: "Patient's location*",
            border: OutlineInputBorder(),
            hintText: "Please enter the patient's location",
            helperText: '* Required',
          ),
        ),
      ]),
    );
  }
}

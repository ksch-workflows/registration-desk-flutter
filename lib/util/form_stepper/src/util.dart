import "package:flutter/material.dart";

/// see https://flutter.dev/docs/cookbook/forms
abstract class FormStep {
  String get title;

  Widget get body;

  bool validate();
}

/// References
/// - https://stackoverflow.com/questions/57995591/manage-multiple-form-validation-in-stepper-flutter/58004730
/// - https://flutter.dev/docs/cookbook/forms/validation
/// - https://flutter.dev/docs/cookbook/forms/retrieve-input
abstract class FormStepWidget implements Widget {
  String get title;
}

/// Provides access on the values of radio buttons, switches, checkboxes, etc.
///
/// References
/// - https://api.flutter.dev/flutter/material/Checkbox-class.html
/// - https://api.flutter.dev/flutter/material/Switch-class.html
/// - https://api.flutter.dev/flutter/material/Radio-class.html
class FormValue<T> {
  T? value;
}

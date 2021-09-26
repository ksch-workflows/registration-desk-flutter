import 'package:flutter/material.dart';

import 'app.dart';
import 'context.dart';

void main() {
  var apiBaseUrl = const String.fromEnvironment(
    'apiBaseUrl',
    defaultValue: 'http://localhost:8080',
  );
  initialiseContext(apiBaseUrl);

  runApp(RegistrationDeskApp());
}

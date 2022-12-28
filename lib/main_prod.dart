import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ksch_dart_client/core.dart';

import 'api/patient/patient_service.dart';
import 'api/visit/visit_service.dart';
import 'app.dart';

void main() {
  var api = KschApi(baseUrl);

  GetIt.I.registerSingleton<PatientService>(PatientServiceImpl(api));
  GetIt.I.registerSingleton<VisitService>(VisitServiceImpl(api));

  runApp(RegistrationDeskApp());
}

/// The protocol and domain of the resource server.
String get baseUrl {
  const result = String.fromEnvironment(
    'apiBaseUrl'
  );
  if (result.isEmpty) {
    throw ConfigurationException('Could not find "apiBaseUrl" in environment');
  }
  return result;
}

class ConfigurationException implements Exception {
  final String message;

  ConfigurationException(this.message);

  @override
  String toString() => message;
}

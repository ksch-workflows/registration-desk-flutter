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
///
/// See [Api Url Parts Nomenclature | stackoverflow.com](https://stackoverflow.com/a/55815212/2339010)
String get baseUrl {
  // TODO Don't default to :8080 in prod profile
  return const String.fromEnvironment(
    'apiBaseUrl',
    defaultValue: 'http://localhost:8080',
  );
}

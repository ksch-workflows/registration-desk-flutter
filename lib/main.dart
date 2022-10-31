import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ksch_dart_client/core.dart';

import 'api/patient/patient_service.dart';
import 'api/visit/visit_service.dart';
import 'app.dart';

void main() {
  var api = KschApi(
    const String.fromEnvironment(
      'apiBaseUrl',
      // TODO How does this work now?
      defaultValue: 'http://localhost:8080',
    ),
  );

  runHealthCheck(api);

  GetIt.I.registerSingleton<PatientService>(PatientServiceImpl(api));
  GetIt.I.registerSingleton<VisitService>(VisitServiceImpl(api));

  runApp(RegistrationDeskApp());
}

// TODO That is no obsolete, isn't it?
/// Triggers wakeup of sleeping servers and provides debugging information.
Future<void> runHealthCheck(KschApi api) async {
  try {
    var healthResponse = await api.actuator.health.get();
    if (healthResponse.status == 'UP') {
      print('[INFO] Backend is up and running');
    } else {
      print('[ERROR] Backend is down');
    }
  } on HttpException catch (e) {
    print('[ERROR] Failed to run health check for backend: '
        '${e.statusCode} - ${e.responseBody}');
  }
}

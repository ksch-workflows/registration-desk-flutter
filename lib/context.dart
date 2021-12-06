import 'package:get_it/get_it.dart';
import 'package:ksch_dart_client/core.dart';

import 'api/patient/patient_service.dart';
import 'api/visit/visit_service.dart';
import 'utils/test_bench/mock_patient_service.dart';
import 'utils/test_bench/mock_visit_service.dart';

void initialiseContext(String apiBaseUrl) {
  var api = KschApi(apiBaseUrl);

  GetIt.I.registerSingleton<PatientService>(PatientServiceImpl(apiBaseUrl));
  GetIt.I.registerSingleton<VisitService>(VisitServiceImpl(api));
}

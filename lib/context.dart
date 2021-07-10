import 'package:get_it/get_it.dart';
import 'api/patient/patient_service.dart';
import 'api/visit/visit_service.dart';

void initialiseContext(String apiBaseUrl) {
  GetIt.I.registerSingleton<PatientService>(PatientServiceImpl(apiBaseUrl));
  GetIt.I.registerSingleton<VisitService>(MockVisitService());
}

void initialiseMockContext() {
  GetIt.I.registerSingleton<PatientService>(MockPatientService());
  GetIt.I.registerSingleton<VisitService>(MockVisitService());
}

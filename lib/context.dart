import 'package:get_it/get_it.dart';
import 'api/patient/patient_service.dart';
import 'api/visit/visit_service.dart';

void createMockContext() {
  GetIt.I.registerSingleton<PatientService>(MockPatientService());
  GetIt.I.registerSingleton<VisitService>(MockVisitService());
}

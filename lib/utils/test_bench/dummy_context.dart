import 'package:get_it/get_it.dart';

import '../../api/patient/patient_service.dart';
import '../../api/visit/visit_service.dart';
import 'dummy_patient_service.dart';
import 'dummy_visit_service.dart';

class DummyAppContext {
  final patientService = DummyPatientService();
  final visitService = DummyVisitService();

  void init() {
    GetIt.I.registerSingleton<PatientService>(patientService);
    GetIt.I.registerSingleton<VisitService>(visitService);
  }
}

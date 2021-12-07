import 'package:ksch_dart_client/core.dart';

import 'patient.dart';

abstract class PatientService {
  Future<Patient> create(Patient? patient);

  Future<Patient> get(String patientId);

  Future<List<Patient>> find(String query);
}

class PatientServiceImpl implements PatientService {
  final KschApi _api;

  PatientServiceImpl(this._api);

  @override
  Future<Patient> create(Patient? patient) async {
    late PatientResponsePayload response;
    if (patient == null) {
      response = await _api.patients.create();
    } else {
      response = await _api.patients.create(CreatePatientRequestPayload(
        name: patient.name,
        residentialAddress: patient.location,
        gender: patient.gender,
        patientCategory: patient.category,
      ));
    }
    print('Patient created: ${response.id}');
    return Patient.from(response);
  }

  @override
  Future<List<Patient>> find(String query) async {
    var searchResults = await _api.patients.search(query);
    return searchResults.patients.map((p) => Patient.from(p)).toList();
  }

  @override
  Future<Patient> get(String patientId) async {
    var response = await _api.patients(patientId).get();
    return Patient.from(response);
  }
}

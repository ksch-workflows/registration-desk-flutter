import 'package:uuid/uuid.dart';

import '../../api/patient/patient.dart';
import '../../api/patient/patient_service.dart';

class DummyPatientService implements PatientService {
  late List<Patient> patientsResponse;
  late Patient patientResponse;

  Duration? delay;

  Future<void> _simulateNetworkDelay() async {
    if (delay != null) {
      await Future.delayed(delay!, () {});
    }
  }

  @override
  Future<Patient> create(Patient? patient) async {
    await _simulateNetworkDelay();
    if (patient == null) {
      patientResponse = Patient(
        id: const Uuid().v4(),
        opdNumber: null,
        name: null,
        fatherName: null,
        location: null,
        gender: null,
        currentVisit: null,
        lastVisit: null,
        category: null,
      );
    } else {
      patientResponse = Patient(
        id: const Uuid().v4(),
        opdNumber: patient.opdNumber,
        name: patient.name,
        fatherName: patient.fatherName,
        location: patient.location,
        gender: patient.gender,
        currentVisit: patient.currentVisit,
        lastVisit: patient.lastVisit,
        category: patient.category,
      );
    }
    return patientResponse;
  }

  @override
  Future<Patient> get(String patientId) async {
    await _simulateNetworkDelay();
    return Patient(
      id: patientId,
      opdNumber: patientResponse.opdNumber,
      name: patientResponse.name,
      fatherName: patientResponse.fatherName,
      location: patientResponse.location,
      gender: patientResponse.gender,
      currentVisit: patientResponse.currentVisit,
      lastVisit: patientResponse.lastVisit,
      category: patientResponse.category,
    );
  }

  @override
  Future<List<Patient>> find(String query) async {
    await _simulateNetworkDelay();
    return patientsResponse;
  }
}

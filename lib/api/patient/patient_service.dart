import 'package:ksch_dart_client/src/client.dart';
import 'package:ksch_dart_client/src/patients/payload.dart';
import 'package:uuid/uuid.dart';

import 'patient.dart';

int _nextOptNumberSuffix = 9000;

abstract class PatientService {
  Future<Patient> create(Patient? patient);

  Future<Patient> get(String patientId);

  Future<List<Patient>> find(String query);
}

class PatientServiceImpl implements PatientService {
  final KschApi _api;

  PatientServiceImpl(String baseUrl) : _api = KschApi(baseUrl);

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
    return Patient.from(response);
  }

  // TODO How to handle multiple pages?
  @override
  Future<List<Patient>> find(String query) async {
    var searchResults = await _api.patients.search(query);
    return searchResults.patients
        .map((p) => Patient.from(p))
        .toList();
  }

  @override
  Future<Patient> get(String patientId) async {
    var response = await _api.patients(patientId).get();
    return Patient.from(response);
  }
}

class MockPatientService implements PatientService {
  @override
  Future<Patient> create(Patient? patient) {
    final result = Patient(
      id: const Uuid().v4(),
      name: patient!.name,
      opdNumber: '20-${_nextOptNumberSuffix++}',
      location: patient.location,
    );
    _mockPatientRepository.add(result);
    return Future.sync(() => result);
  }

  @override
  Future<Patient> get(String patientId) {
    var result = _mockPatientRepository.where((element) => element.id == patientId).first;
    return Future.sync(() => result);
  }

  @override
  Future<List<Patient>> find(String patientName) {
    var result = _mockPatientRepository
        .where((patient) => patient.name != null)
        .where((patient) => patient.name!.toLowerCase().contains(patientName))
        .toList();
    return Future.sync(() => result);
  }
}

// TODO Move mock data into separate directory or at least file
final List<Patient> _mockPatientRepository = [
  Patient(
    id: const Uuid().v4().toString(),
    opdNumber: '10-1102',
    name: 'John Doe',
    location: 'Guesthouse',
    lastVisit: DateTime.now(),
  ),
  Patient(
      id: const Uuid().v4().toString(),
      opdNumber: '10-2001',
      name: 'Akrodhana Kalirai',
      location: 'Academy',
      lastVisit: DateTime.now()),
  Patient(
    id: const Uuid().v4().toString(),
    opdNumber: '10-2002',
    name: 'Balaja Sarup',
    location: 'Academy',
    lastVisit: DateTime.now(),
  ),
  Patient(
      id: const Uuid().v4().toString(),
      opdNumber: '10-2003',
      name: 'Abhidipa Raghunandan',
      location: 'Academy',
      lastVisit: DateTime.now()),
  Patient(
      id: const Uuid().v4().toString(),
      opdNumber: '10-2004',
      name: 'Padmavati Harku',
      location: 'Academy',
      lastVisit: DateTime.now()),
  Patient(
    id: const Uuid().v4().toString(),
    opdNumber: '10-2005',
    name: 'Budh Kalpak',
    location: 'Academy',
    lastVisit: DateTime.now(),
  ),
  Patient(
      id: const Uuid().v4().toString(),
      opdNumber: '10-2006',
      name: 'Sarala Mousumi',
      location: 'Academy',
      lastVisit: DateTime.now()),
  Patient(
    id: const Uuid().v4().toString(),
    opdNumber: '10-2007',
    name: 'Mathur Tanuja',
    location: 'Academy',
    lastVisit: DateTime.now(),
  ),
  Patient(
      id: const Uuid().v4().toString(),
      opdNumber: '10-2008',
      name: 'Jvalitri Mandhatri',
      location: 'Academy',
      lastVisit: DateTime.now()),
  Patient(
      id: const Uuid().v4().toString(),
      opdNumber: '10-2009',
      name: 'Karnikara Rachna',
      location: 'Academy',
      lastVisit: DateTime.now()),
  Patient(
      id: const Uuid().v4().toString(),
      opdNumber: '10-2010',
      name: 'Atmajyoti Vanita',
      location: 'Academy',
      lastVisit: DateTime.now()),
  Patient(
      id: const Uuid().v4().toString(),
      opdNumber: '10-2011',
      name: 'Jaibhusana Nirupa',
      location: 'Academy',
      lastVisit: DateTime.now()),
  Patient(
    id: const Uuid().v4().toString(),
    opdNumber: '10-2012',
    name: 'Jaisila Vikul',
    location: 'Academy',
    lastVisit: DateTime.now(),
  ),
  Patient(
    id: const Uuid().v4().toString(),
    opdNumber: '10-2013',
    name: 'Ravindra Kodanda',
    location: 'Academy',
    lastVisit: DateTime.now(),
  ),
  Patient(
    id: const Uuid().v4().toString(),
    opdNumber: '10-2014',
    name: 'Bhanu Sivakumar',
    location: 'Academy',
    lastVisit: DateTime.now(),
  ),
  Patient(
    id: const Uuid().v4().toString(),
    opdNumber: '10-2015',
    name: 'Bhrigu Srivathsan',
    location: 'Academy',
    lastVisit: DateTime.now(),
  ),
  Patient(
    id: const Uuid().v4().toString(),
    opdNumber: '10-2016',
    name: 'Atyantika Prudvi',
    location: 'Academy',
    lastVisit: DateTime.now(),
  ),
  Patient(
    id: const Uuid().v4().toString(),
    opdNumber: '10-2017',
    name: 'Janabalika Harku',
    location: 'Academy',
    lastVisit: DateTime.now(),
  ),
  Patient(
    id: const Uuid().v4().toString(),
    opdNumber: '10-2018',
    name: 'Javeed Sarath',
    location: 'Academy',
    lastVisit: DateTime.now(),
  ),
  Patient(
    id: const Uuid().v4().toString(),
    opdNumber: '10-2019',
    name: 'Madhusudhana Varati',
    location: 'Academy',
    lastVisit: DateTime.now(),
  ),
  Patient(
      id: const Uuid().v4().toString(),
      opdNumber: '10-2020',
      name: 'Kancanabha Nithin',
      location: 'Academy',
      lastVisit: DateTime.now()),
  Patient(
      id: const Uuid().v4().toString(),
      opdNumber: '10-3001',
      name: 'Jane Doe',
      location: 'Academy',
      lastVisit: DateTime.now()),
  Patient(
      id: const Uuid().v4().toString(),
      opdNumber: '10-3002',
      name: 'Jane Doe',
      location: 'Academy',
      lastVisit: DateTime.now()),
  Patient(
      id: const Uuid().v4().toString(),
      opdNumber: '10-3003',
      name: 'Jane Doe',
      location: 'Academy',
      lastVisit: DateTime.now()),
  Patient(
      id: const Uuid().v4().toString(),
      opdNumber: '10-3004',
      name: 'Jane Doe',
      location: 'Academy',
      lastVisit: DateTime.now()),
  Patient(
      id: const Uuid().v4().toString(),
      opdNumber: '10-3005',
      name: 'Jane Doe',
      location: 'Academy',
      lastVisit: DateTime.now()),
  Patient(
      id: const Uuid().v4().toString(),
      opdNumber: '10-3006',
      name: 'Jane Doe',
      location: 'Academy',
      lastVisit: DateTime.now()),
  Patient(
      id: const Uuid().v4().toString(),
      opdNumber: '10-3007',
      name: 'Jane Doe',
      location: 'Academy',
      lastVisit: DateTime.now()),
  Patient(
      id: const Uuid().v4().toString(),
      opdNumber: '10-3009',
      name: 'Jane Doe',
      location: 'Academy',
      lastVisit: DateTime.now()),
  Patient(
      id: const Uuid().v4().toString(),
      opdNumber: '10-3010',
      name: 'Jane Doe',
      location: 'Academy',
      lastVisit: DateTime.now()),
  Patient(
      id: const Uuid().v4().toString(),
      opdNumber: '10-3011',
      name: 'Jane Doe',
      location: 'Academy',
      lastVisit: DateTime.now()),
  Patient(
      id: const Uuid().v4().toString(),
      opdNumber: '10-3012',
      name: 'Jane Doe',
      location: 'Academy',
      lastVisit: DateTime.now()),
  Patient(
      id: const Uuid().v4().toString(),
      opdNumber: '10-3013',
      name: 'Jane Doe',
      location: 'Academy',
      lastVisit: DateTime.now()),
  Patient(
      id: const Uuid().v4().toString(),
      opdNumber: '10-3014',
      name: 'Jane Doe',
      location: 'Academy',
      lastVisit: DateTime.now()),
  Patient(
      id: const Uuid().v4().toString(),
      opdNumber: '10-3015',
      name: 'Jane Doe',
      location: 'Academy',
      lastVisit: DateTime.now()),
];

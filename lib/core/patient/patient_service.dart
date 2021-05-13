import "package:uuid/uuid.dart";

import "patient.dart";

int _nextOptNumberSuffix = 9000;

abstract class PatientService {
  Patient create(Patient patient);
  Patient get(String patientId);
  List<Patient> find(String patientName);
}

class MockPatientService implements PatientService {
  @override
  Patient create(Patient patient) {
    final result = Patient(
      id: Uuid().v4(),
      name: patient.name,
      opdNumber: "20-${_nextOptNumberSuffix++}",
      location: patient.location,
    );
    _mockPatientRepository.add(result);
    return result;
  }

  @override
  Patient get(String patientId) {
    return _mockPatientRepository.where((element) => element.id == patientId).first;
  }

  @override
  List<Patient> find(String patientName) {
    return _mockPatientRepository.where((patient) => patient.name.toLowerCase().contains(patientName)).toList();
  }
}

final List<Patient> _mockPatientRepository = [
  Patient(
    id: Uuid().v4().toString(),
    opdNumber: "10-1102",
    name: "John Doe",
    location: "Guesthouse",
    lastVisit: DateTime.now(),
  ),
  Patient(
      id: Uuid().v4().toString(),
      opdNumber: "10-2001",
      name: "Akrodhana Kalirai",
      location: "Academy",
      lastVisit: DateTime.now()),
  Patient(
    id: Uuid().v4().toString(),
    opdNumber: "10-2002",
    name: "Balaja Sarup",
    location: "Academy",
    lastVisit: DateTime.now(),
  ),
  Patient(
      id: Uuid().v4().toString(),
      opdNumber: "10-2003",
      name: "Abhidipa Raghunandan",
      location: "Academy",
      lastVisit: DateTime.now()),
  Patient(
      id: Uuid().v4().toString(),
      opdNumber: "10-2004",
      name: "Padmavati Harku",
      location: "Academy",
      lastVisit: DateTime.now()),
  Patient(
    id: Uuid().v4().toString(),
    opdNumber: "10-2005",
    name: "Budh Kalpak",
    location: "Academy",
    lastVisit: DateTime.now(),
  ),
  Patient(
      id: Uuid().v4().toString(),
      opdNumber: "10-2006",
      name: "Sarala Mousumi",
      location: "Academy",
      lastVisit: DateTime.now()),
  Patient(
    id: Uuid().v4().toString(),
    opdNumber: "10-2007",
    name: "Mathur Tanuja",
    location: "Academy",
    lastVisit: DateTime.now(),
  ),
  Patient(
      id: Uuid().v4().toString(),
      opdNumber: "10-2008",
      name: "Jvalitri Mandhatri",
      location: "Academy",
      lastVisit: DateTime.now()),
  Patient(
      id: Uuid().v4().toString(),
      opdNumber: "10-2009",
      name: "Karnikara Rachna",
      location: "Academy",
      lastVisit: DateTime.now()),
  Patient(
      id: Uuid().v4().toString(),
      opdNumber: "10-2010",
      name: "Atmajyoti Vanita",
      location: "Academy",
      lastVisit: DateTime.now()),
  Patient(
      id: Uuid().v4().toString(),
      opdNumber: "10-2011",
      name: "Jaibhusana Nirupa",
      location: "Academy",
      lastVisit: DateTime.now()),
  Patient(
    id: Uuid().v4().toString(),
    opdNumber: "10-2012",
    name: "Jaisila Vikul",
    location: "Academy",
    lastVisit: DateTime.now(),
  ),
  Patient(
    id: Uuid().v4().toString(),
    opdNumber: "10-2013",
    name: "Ravindra Kodanda",
    location: "Academy",
    lastVisit: DateTime.now(),
  ),
  Patient(
    id: Uuid().v4().toString(),
    opdNumber: "10-2014",
    name: "Bhanu Sivakumar",
    location: "Academy",
    lastVisit: DateTime.now(),
  ),
  Patient(
    id: Uuid().v4().toString(),
    opdNumber: "10-2015",
    name: "Bhrigu Srivathsan",
    location: "Academy",
    lastVisit: DateTime.now(),
  ),
  Patient(
    id: Uuid().v4().toString(),
    opdNumber: "10-2016",
    name: "Atyantika Prudvi",
    location: "Academy",
    lastVisit: DateTime.now(),
  ),
  Patient(
    id: Uuid().v4().toString(),
    opdNumber: "10-2017",
    name: "Janabalika Harku",
    location: "Academy",
    lastVisit: DateTime.now(),
  ),
  Patient(
    id: Uuid().v4().toString(),
    opdNumber: "10-2018",
    name: "Javeed Sarath",
    location: "Academy",
    lastVisit: DateTime.now(),
  ),
  Patient(
    id: Uuid().v4().toString(),
    opdNumber: "10-2019",
    name: "Madhusudhana Varati",
    location: "Academy",
    lastVisit: DateTime.now(),
  ),
  Patient(
      id: Uuid().v4().toString(),
      opdNumber: "10-2020",
      name: "Kancanabha Nithin",
      location: "Academy",
      lastVisit: DateTime.now()),
  Patient(id: Uuid().v4().toString(), opdNumber: "10-3001", name: "Jane Doe", location: "Academy", lastVisit: DateTime.now()),
  Patient(id: Uuid().v4().toString(), opdNumber: "10-3002", name: "Jane Doe", location: "Academy", lastVisit: DateTime.now()),
  Patient(id: Uuid().v4().toString(), opdNumber: "10-3003", name: "Jane Doe", location: "Academy", lastVisit: DateTime.now()),
  Patient(id: Uuid().v4().toString(), opdNumber: "10-3004", name: "Jane Doe", location: "Academy", lastVisit: DateTime.now()),
  Patient(id: Uuid().v4().toString(), opdNumber: "10-3005", name: "Jane Doe", location: "Academy", lastVisit: DateTime.now()),
  Patient(id: Uuid().v4().toString(), opdNumber: "10-3006", name: "Jane Doe", location: "Academy", lastVisit: DateTime.now()),
  Patient(id: Uuid().v4().toString(), opdNumber: "10-3007", name: "Jane Doe", location: "Academy", lastVisit: DateTime.now()),
  Patient(id: Uuid().v4().toString(), opdNumber: "10-3009", name: "Jane Doe", location: "Academy", lastVisit: DateTime.now()),
  Patient(id: Uuid().v4().toString(), opdNumber: "10-3010", name: "Jane Doe", location: "Academy", lastVisit: DateTime.now()),
  Patient(id: Uuid().v4().toString(), opdNumber: "10-3011", name: "Jane Doe", location: "Academy", lastVisit: DateTime.now()),
  Patient(id: Uuid().v4().toString(), opdNumber: "10-3012", name: "Jane Doe", location: "Academy", lastVisit: DateTime.now()),
  Patient(id: Uuid().v4().toString(), opdNumber: "10-3013", name: "Jane Doe", location: "Academy", lastVisit: DateTime.now()),
  Patient(id: Uuid().v4().toString(), opdNumber: "10-3014", name: "Jane Doe", location: "Academy", lastVisit: DateTime.now()),
  Patient(id: Uuid().v4().toString(), opdNumber: "10-3015", name: "Jane Doe", location: "Academy", lastVisit: DateTime.now()),
];

import 'package:equatable/equatable.dart';
import 'package:ksch_dart_client/core.dart';
import 'package:nock/nock.dart';
import 'package:registration_desk/api/patient/patient.dart';
import 'package:registration_desk/api/patient/patient_service.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

import '../../util/request_matcher.dart';

void main() {
  late PatientServiceImpl patientService;

  setUpAll(nock.init);

  setUp(() {
    nock.cleanAll();

    patientService = PatientServiceImpl(KschApi('http://localhost'));
  });

  test('Should create patient', () async {
    var patient = JohnDoe();
    givenCreatePatientResponse(CompletePatientResponse(patient).toJson());

    var result = await patientService.create(patient);

    expect(result.location, equals(patient.location));
    expect(result.category, equals(patient.category));
  });

  test('Should create patient in case of emergency', () async {
    var patientId = const Uuid().v4();
    givenCreatePatientResponse(MinimalPatientResponse(patientId).toJson());

    var result = await patientService.create(null);

    expect(result.id, equals(patientId));
  });
}

void givenCreatePatientResponse(dynamic body) {
  nock('http://localhost').post('/api/patients', any())..reply(200, body);
}

class MinimalPatientResponse extends PatientResponsePayload {
  MinimalPatientResponse(String id)
      : super(
          id: id,
          name: null,
          residentialAddress: null,
          gender: null,
          patientCategory: null,
          links: Links(self: Link(href: 'http://localhost/api/patients/$id')),
        );
}

class CompletePatientResponse extends PatientResponsePayload {
  CompletePatientResponse(Patient patient)
      : super(
          id: patient.id!,
          name: patient.name!,
          residentialAddress: patient.location!,
          gender: patient.gender!,
          patientCategory: patient.category!,
          links: Links(
            self: Link(href: 'http://localhost/api/patients/${patient.id!}'),
          ),
        );
}

class JohnDoe extends Equatable implements Patient {
  final String fatherName = 'Max Mustermann';
  final String gender = 'MALE';
  final String id = const Uuid().v4();
  final String? currentVisit = null;
  final DateTime? lastVisit = null;
  final String location = 'Guesthouse';
  final String name = 'John Doe';
  final String opdNumber = '10-12354';
  final String category = 'OPD';

  @override
  List<Object?> get props => [
        id,
        opdNumber,
        name,
        fatherName,
        location,
        gender,
        currentVisit,
        lastVisit,
        category,
      ];
}

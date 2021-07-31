import 'package:ksch_dart_client/ksch_dart_client.dart';
import 'package:ksch_dart_client/src/patients/payload.dart';
import 'package:nock/nock.dart';
import 'package:registration_desk/api/patient/patient_service.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  late PatientServiceImpl patientService;

  setUpAll(nock.init);

  setUp(() {
    nock.cleanAll();

    patientService = PatientServiceImpl('http://localhost');
  });

  test('Should create patient', () {});

  test('Should create patient in case of emergency', () async {
    var patientId = const Uuid().v4();
    givenCreatePatientResponse(MinimalPatientResponse(patientId).toJson());

    var result = await patientService.create(null);

    expect(result.id, equals(patientId));
  });
}

void givenCreatePatientResponse(dynamic body) {
  nock('http://localhost').post('/api/patients')..reply(200, body);
}

class MinimalPatientResponse extends PatientResponsePayload {
  MinimalPatientResponse(String id)
      : super(
          id: id,
          links: Links(self: Link(href: 'http://localhost/api/patients/$id')),
        );
}

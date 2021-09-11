import 'package:equatable/equatable.dart';
import 'package:ksch_dart_client/ksch_dart_client.dart';
import 'package:registration_desk/api/patient/patient.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  test('Should map patient response payload to patient model', () {
    var response = PatientResponsePayload(
      id: const Uuid().v4(),
      name: 'Jonny Doe',
      residentialAddress: 'Guesthouse',
      links: Links(
        self: Link(href: 'http://localhost'),
      ),
    );

    var parsedPatient = Patient.from(response);

    expect(
      TestPatient.fromModel(parsedPatient),
      equals(TestPatient.fromPayload(response)),
    );
  });
}

class TestPatient extends Equatable implements Patient {
  final String name;
  final String fatherName;
  final String? id;
  final DateTime? lastVisit;
  final String? location;
  final String? opdNumber;

  TestPatient.fromPayload(PatientResponsePayload payload)
      : name = payload.name!,
        fatherName = ,
        id = payload.id,
        lastVisit = null,
        location = payload.residentialAddress,
        opdNumber = null;

  TestPatient.fromModel(Patient patient)
      : name = patient.name!,
        fatherName = patient.fatherName!,
        id = patient.id,
        lastVisit = patient.lastVisit,
        location = patient.location,
        opdNumber = patient.opdNumber;

  @override
  List<Object?> get props => [
        name,
        fatherName,
        id,
        lastVisit,
        location,
        opdNumber,
      ];
}

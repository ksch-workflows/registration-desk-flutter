import 'package:equatable/equatable.dart';
import 'package:ksch_dart_client/core.dart';
import 'package:registration_desk/api/patient/patient.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  test('Should map patient response payload to patient model', () {
    var response = PatientResponsePayload(
      id: const Uuid().v4(),
      name: 'Jonny Doe',
      gender: 'MALE',
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
  final String? fatherName;
  final String? id;
  final DateTime? lastVisit;
  final String? location;
  final String? gender;
  final String? opdNumber;

  TestPatient.fromPayload(PatientResponsePayload payload)
      : name = payload.name!,
        fatherName = null,
        id = payload.id,
        lastVisit = null,
        location = payload.residentialAddress,
        gender = payload.gender,
        opdNumber = null;

  TestPatient.fromModel(Patient patient)
      : name = patient.name!,
        fatherName = patient.fatherName,
        id = patient.id,
        lastVisit = patient.lastVisit,
        location = patient.location,
        gender = patient.gender,
        opdNumber = patient.opdNumber;

  @override
  List<Object?> get props => [
        name,
        fatherName,
        id,
        lastVisit,
        location,
        gender,
        opdNumber,
      ];
}

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
      patientCategory: 'OPD',
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
  final String? currentVisit;
  final DateTime? lastVisit;
  final String? location;
  final String? gender;
  final String? opdNumber;
  final String? category;

  TestPatient.fromPayload(PatientResponsePayload payload)
      : name = payload.name!,
        fatherName = null,
        id = payload.id,
        currentVisit = null,
        lastVisit = null,
        location = payload.residentialAddress,
        gender = payload.gender,
        category = payload.patientCategory,
        opdNumber = null;

  TestPatient.fromModel(Patient patient)
      : name = patient.name!,
        fatherName = patient.fatherName,
        id = patient.id,
        currentVisit = null,
        lastVisit = patient.lastVisit,
        location = patient.location,
        gender = patient.gender,
        category = patient.category,
        opdNumber = patient.opdNumber;

  @override
  List<Object?> get props => [
        name,
        fatherName,
        id,
        currentVisit,
        lastVisit,
        location,
        gender,
        category,
        opdNumber,
      ];
}

import 'package:ksch_dart_client/core.dart';

class Patient {
  final String? id;
  final String? opdNumber;
  final String? name;
  final String? fatherName;
  final String? location; // TODO Rename to "residentialAddress"
  final String? gender; // TODO Use enum instead of String
  final DateTime? lastVisit;

  Patient({
    this.id,
    this.opdNumber,
    this.name,
    this.fatherName,
    this.location,
    this.gender,
    this.lastVisit,
  });

  Patient.from(PatientResponsePayload payload)
      : id = payload.id,
        opdNumber = null,
        name = payload.name,
        fatherName = null,
        location = payload.residentialAddress,
        gender = payload.gender,
        lastVisit = null;
}

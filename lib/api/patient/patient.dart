import 'package:ksch_dart_client/core.dart';
import 'package:registration_desk/api/visit/visit.dart';

class Patient {
  final String? id;
  final String? opdNumber;
  final String? name;
  final String? fatherName;
  final String? location;
  final String? gender;
  final String? currentVisit;
  // TODO Probably this should also be just an ID
  final DateTime? lastVisit;
  final String? category;

  Patient({
    this.id,
    this.opdNumber,
    this.name,
    this.fatherName,
    this.location,
    this.gender,
    this.currentVisit,
    this.lastVisit,
    this.category,
  });

  Patient.from(PatientResponsePayload payload)
      : id = payload.id,
        opdNumber = null,
        name = payload.name,
        fatherName = null,
        location = payload.residentialAddress,
        gender = payload.gender,
        category = payload.patientCategory,
        currentVisit = payload.links.currentVisit?.visitId,
        lastVisit = null;
}

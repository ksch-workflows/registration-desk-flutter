import 'package:equatable/equatable.dart';
import 'package:ksch_dart_client/core.dart';
import 'package:registration_desk/api/visit/visit.dart';

class Patient extends Equatable {
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

  const Patient({
    required this.id,
    required this.opdNumber,
    required this.name,
    required this.fatherName,
    required this.location,
    required this.gender,
    required this.currentVisit,
    required this.lastVisit,
    required this.category,
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

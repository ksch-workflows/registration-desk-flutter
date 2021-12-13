part of 'register_patient_bloc.dart';

abstract class RegisterPatientEvent extends Equatable {
  const RegisterPatientEvent();

  @override
  List<Object?> get props => [];
}

class RegisterNewPatientRequested extends RegisterPatientEvent {}

class PatientSearchResultSelected extends RegisterPatientEvent {
  final String patientId;

  const PatientSearchResultSelected(this.patientId);

  @override
  List<Object?> get props => [patientId];
}

class NewPatientSaved extends RegisterPatientEvent {
  final Patient patient;
  final VisitType visitType;

  const NewPatientSaved(this.patient, this.visitType);

  @override
  List<Object?> get props => [patient, visitType];
}

class PatientRegistrationStopped extends RegisterPatientEvent {}

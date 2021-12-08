part of 'register_patient_bloc.dart';

abstract class RegisterPatientEvent extends Equatable {
  const RegisterPatientEvent();

  @override
  List<Object?> get props => [];
}

class RegisterNewPatientRequested extends RegisterPatientEvent {}

class NewPatientSaved extends RegisterPatientEvent {
  final Patient patient;
  final VisitType visitType;

  const NewPatientSaved(this.patient, this.visitType);
}

class PatientRegistrationStopped extends RegisterPatientEvent {}

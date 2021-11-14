part of 'patient_resource_bloc.dart';

abstract class PatientState extends Equatable {
  const PatientState();
}

class LoadingPatient extends PatientState {
  final String patientId;

  const LoadingPatient(this.patientId);

  @override
  List<Object?> get props => [];
}

class DisplayingPatient extends PatientState {
  final Patient patient;
  final Visit? visit;

  const DisplayingPatient({
    required this.patient,
    this.visit,
  });

  @override
  List<Object?> get props => [patient, visit];
}

class DisplayingError extends PatientState {
  @override
  List<Object?> get props => [];
}

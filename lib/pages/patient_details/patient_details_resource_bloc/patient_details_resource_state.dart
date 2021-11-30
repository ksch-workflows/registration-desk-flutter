part of 'patient_details_resource_bloc.dart';

abstract class PatientState extends Equatable {
  const PatientState();
}

class LoadingPatientDetails extends PatientState {
  final String patientId;

  const LoadingPatientDetails(this.patientId);

  @override
  List<Object?> get props => [];
}

class DisplayingPatientDetails extends PatientState {
  final Patient patient;
  final Visit? visit;

  const DisplayingPatientDetails({
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

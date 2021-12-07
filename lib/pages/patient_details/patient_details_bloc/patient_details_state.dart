part of 'patient_details_bloc.dart';

abstract class PatientDetailsState extends Equatable {
  const PatientDetailsState();

  @override
  List<Object?> get props => [];
}

class LoadingPatientDetails extends PatientDetailsState {
  final String patientId;

  const LoadingPatientDetails(this.patientId);
}

class DisplayingPatientDetails extends PatientDetailsState {
  final Patient patient;
  final Visit? visit;

  const DisplayingPatientDetails({
    required this.patient,
    this.visit,
  });

  @override
  List<Object?> get props => [patient, visit];
}

class DisplayingError extends PatientDetailsState {}

class NavigatingBack extends PatientDetailsState {}

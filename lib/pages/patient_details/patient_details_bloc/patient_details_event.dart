part of 'patient_details_bloc.dart';

abstract class PatientDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PatientLoaded extends PatientDetailsEvent {
  final Patient patient;
  final Visit? visit;

  PatientLoaded({required this.patient, required this.visit});

  @override
  List<Object?> get props => [patient, visit];
}

class NavigateBackRequested extends PatientDetailsEvent {}

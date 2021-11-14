part of 'patient_resource_bloc.dart';

abstract class PatientEvent extends Equatable {
  final Patient patient;
  final Visit? visit;

  const PatientEvent({required this.patient, required this.visit});

  @override
  List<Object?> get props => [patient, visit];
}

class PatientLoaded extends PatientEvent {
  const PatientLoaded({
    required Patient patient,
    required Visit? visit,
  }) : super(
          patient: patient,
          visit: visit,
        );
}

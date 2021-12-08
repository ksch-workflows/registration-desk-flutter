part of 'register_patient_bloc.dart';

abstract class RegisterPatientState extends Equatable {
  const RegisterPatientState();

  @override
  List<Object?> get props => [];
}

class ShowingRegisterPatientPage extends RegisterPatientState {}

class SavingPatient extends RegisterPatientState {}

class OpeningRegisterPatientDialog extends RegisterPatientState {}

class ClosingRegisterPatientDialog extends RegisterPatientState {}

class NavigatingToPatientDetailsPage extends RegisterPatientState {
  final String patientId;

  const NavigatingToPatientDetailsPage(this.patientId);
}

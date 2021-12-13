part of 'register_patient_bloc.dart';

abstract class RegisterPatientState extends Equatable {
  final String id = const Uuid().v4();

  RegisterPatientState();

  @override
  List<Object?> get props => [id];
}

class ShowingRegisterPatientPage extends RegisterPatientState {}

class SavingPatient extends RegisterPatientState {}

class OpeningRegisterPatientDialog extends RegisterPatientState {}

class ClosingRegisterPatientDialog extends RegisterPatientState {}

class NavigatingToPatientDetailsPage extends RegisterPatientState {
  final String patientId;

  NavigatingToPatientDetailsPage(this.patientId);
}

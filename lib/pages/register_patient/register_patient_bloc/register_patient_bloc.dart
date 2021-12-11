import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:ksch_dart_client/resources.dart';
import 'package:uuid/uuid.dart';

import '../../../api/patient/patient.dart';
import '../../../api/patient/patient_service.dart';
import '../../../api/visit/visit_service.dart';

part 'register_patient_event.dart';

part 'register_patient_state.dart';

class RegisterPatientBloc
    extends Bloc<RegisterPatientEvent, RegisterPatientState> {
  final PatientService patientService = GetIt.I<PatientService>();
  final VisitService visitService = GetIt.I<VisitService>();

  RegisterPatientBloc() : super(ShowingRegisterPatientPage()) {
    on<NewPatientSaved>((event, emit) async {
      emit(SavingPatient());
      final createdPatient = await patientService.create(event.patient);
      await visitService.startVisit(createdPatient.id!, event.visitType);
      emit(NavigatingToPatientDetailsPage(createdPatient.id!));
    });

    on<PatientRegistrationStopped>((event, emit) {
      emit(ClosingRegisterPatientDialog());
    });
  }
}

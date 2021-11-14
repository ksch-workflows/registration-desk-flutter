import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:registration_desk/api/patient/patient.dart';
import 'package:registration_desk/api/patient/patient_service.dart';
import 'package:registration_desk/api/visit/visit.dart';
import 'package:registration_desk/api/visit/visit_service.dart';

part 'patient_resource_event.dart';

part 'patient_resource_state.dart';

class PatientResourceBloc extends Bloc<PatientEvent, PatientState> {
  final PatientService patientService = GetIt.I.get();
  final VisitService visitService = GetIt.I.get();

  final String patientId;

  PatientResourceBloc({
    required this.patientId,
  }) : super(LoadingPatient(patientId)) {
    on<PatientEvent>((event, emit) {
      emit(DisplayingPatient(patient: event.patient, visit: event.visit));
    });
    _fetchPatient();
  }

  Future<void> _fetchPatient() async {
    var patient = await patientService.get(patientId);
    var currentVisit = patient.currentVisit;
    Visit? visit;
    if (currentVisit != null) {
      visit = await visitService.get(
        patientId: patient.id!,
        visitId: currentVisit,
      );
    }
    add(PatientLoaded(patient: patient, visit: visit));
  }
}

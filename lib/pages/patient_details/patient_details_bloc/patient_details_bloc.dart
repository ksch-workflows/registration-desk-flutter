import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../api/patient/patient.dart';
import '../../../api/patient/patient_service.dart';
import '../../../api/visit/visit.dart';
import '../../../api/visit/visit_service.dart';

part 'patient_details_event.dart';

part 'patient_details_state.dart';

class PatientDetailsBloc
    extends Bloc<PatientDetailsEvent, PatientDetailsState> {
  final PatientService patientService = GetIt.I.get();
  final VisitService visitService = GetIt.I.get();

  final String patientId;

  PatientDetailsBloc({
    required this.patientId,
  }) : super(LoadingPatientDetails(patientId)) {
    on<PatientLoaded>((event, emit) {
      emit(
        DisplayingPatientDetails(patient: event.patient, visit: event.visit),
      );
    });

    on<NavigateBackRequested>((event, emit) {
      emit(NavigatingBack());
    });

    _fetchPatientDetails();
  }

  Future<void> _fetchPatientDetails() async {
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

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:registration_desk/widgets/patient_summary_panel/patient_summary_panel.dart';

import '../../api/patient/patient.dart';
import '../../api/patient/patient_service.dart';
import '../../api/visit/visit.dart';
import '../../api/visit/visit_service.dart';
import '../../routing.dart';
import '../../widgets/scaffold.dart';
import '../dashboard/index.dart';

final _patientService = GetIt.I.get<PatientService>();
final _visitService = GetIt.I.get<VisitService>();

class PatientDetailsPage extends StatefulWidget {
  final String patientId;

  const PatientDetailsPage(this.patientId, {Key? key}) : super(key: key);

  @override
  State<PatientDetailsPage> createState() => _PatientDetailsPageState();
}

class _PatientDetailsPageState extends State<PatientDetailsPage> {
  late Future<PatientDetailsModel> model;

  @override
  void initState() {
    model = getPatientDetails();
    super.initState();
  }

  Future<PatientDetailsModel> getPatientDetails() async {
    print("Start");
    var patient = await _patientService.get(widget.patientId);
    var currentVisit = patient.currentVisit;
    Visit? visit;
    if (currentVisit != null) {
      visit = await _visitService.get(
          patientId: patient.id!, visitId: currentVisit);
    }
    print("End");
    return PatientDetailsModel(patient: patient, visit: visit);
  }

  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      title: 'Patient details',
      onNavigateBack: () {
        Navigator.push(
          context,
          WebPageRoute(builder: (context) => RegistrationDashboard()),
        );
      },
      body: FutureBuilder(
          future: model,
          builder: (context, AsyncSnapshot<PatientDetailsModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return Column();
            }

            return const Text('An error occurred.');
          }),
    );
  }
}

class PatientDetailsModel {
  final Patient patient;
  final Visit? visit;

  PatientDetailsModel({
    required this.patient,
    this.visit,
  });
}

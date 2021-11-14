import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:registration_desk/pages/patient_details/patient_resource_bloc/patient_resource_bloc.dart';
import 'package:registration_desk/widgets/patient_summary_panel/patient_summary_panel.dart';

import '../../api/patient/patient.dart';
import '../../api/patient/patient_service.dart';
import '../../api/visit/visit.dart';
import '../../api/visit/visit_service.dart';
import '../../routing.dart';
import '../../widgets/scaffold.dart';
import '../dashboard/index.dart';

final PatientService _patientService = GetIt.I.get();
final VisitService _visitService = GetIt.I.get();

class PatientDetailsPage extends StatelessWidget {
  final String patientId;

  const PatientDetailsPage(this.patientId, {Key? key}) : super(key: key);

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
      body: BlocProvider(
        create: (context) => PatientResourceBloc(
          patientId: patientId,
          patientService: _patientService,
          visitService: _visitService,
        ),
        child: BlocBuilder<PatientResourceBloc, PatientState>(
          builder: (context, state) {
            if (state is LoadingPatient) {
              return Text("Loading");
            }
            if (state is DisplayingPatient) {
              return Text("Displaying patient");
            }
            return const Text('An error occurred');
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../routing.dart';
import '../../widgets/scaffold/index.dart';
import '../../widgets/scaffold/tabbed_details_panel.dart';
import '../dashboard/index.dart';
import 'patient_details_bloc/patient_details_bloc.dart';
import 'tabs/general_tab.dart';
import 'tabs/visits_tab.dart';

class PatientDetailsPage extends StatelessWidget {
  final String patientId;

  const PatientDetailsPage(this.patientId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatientDetailsBloc(patientId: patientId),
      child: BlocConsumer<PatientDetailsBloc, PatientDetailsState>(
        listener: (context, state) {
          if (state is NavigatingBack) {
            Navigator.push(
              context,
              DesktopPageRoute(builder: (context) => RegistrationDashboard()),
            );
            return;
          }
        },
        builder: (context, state) {
          return DesktopScaffold(
            title: 'Patient details',
            onNavigateBack: () {
              context.read<PatientDetailsBloc>().add(NavigateBackRequested());
            },
            child: BlocBuilder<PatientDetailsBloc, PatientDetailsState>(
              builder: (context, state) {
                if (state is LoadingPatientDetails) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is DisplayingPatientDetails) {
                  return TabbedDetailsPanel(
                    patient: state.patient,
                    tabs: [
                      SummaryPanelTab(
                        title: 'General',
                        child: GeneralTabContent(patient: state.patient),
                      ),
                      SummaryPanelTab(
                        title: 'Visits',
                        child: VisitsTabContent(currentVisit: state.visit),
                      ),
                    ],
                    initialTabIndex: 1,
                  );
                }
                return const Text('An error occurred');
              },
            ),
          );
        },
        buildWhen: (previous, current) => false,
      ),
    );
  }
}

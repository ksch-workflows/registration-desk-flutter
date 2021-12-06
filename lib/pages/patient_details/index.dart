import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/patient/patient.dart';
import '../../api/visit/visit.dart';
import '../../routing.dart';
import '../../widgets/content_card/index.dart';
import '../../widgets/scaffold/index.dart';
import '../../widgets/scaffold/tabbed_details_panel.dart';
import '../dashboard/index.dart';
import 'patient_details_resource_bloc/patient_details_resource_bloc.dart';

class PatientDetailsPage extends StatelessWidget {
  final String patientId;

  const PatientDetailsPage(this.patientId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DesktopScaffold(
      title: 'Patient details',
      onNavigateBack: () {
        Navigator.push(
          context,
          DesktopPageRoute(builder: (context) => RegistrationDashboard()),
        );
      },
      child: BlocProvider(
        create: (context) => PatientDetailsResourceBloc(patientId: patientId),
        child: BlocBuilder<PatientDetailsResourceBloc, PatientState>(
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
      ),
    );
  }
}

class GeneralTabContent extends StatelessWidget {
  final Patient patient;

  @visibleForTesting
  const GeneralTabContent({
    required this.patient,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContentCard(
          title: const ContentCardTitle(
            text: 'Identity',
            icon: Icons.badge,
          ),
          info: [
            ContentCardInfo(
              key: 'Name',
              value: patient.name ?? 'unknown',
            ),
            ContentCardInfo(
              key: 'Father\'s name',
              value: patient.fatherName ?? 'unknown',
            ),
          ],
          icons: [
            ContentCardIcon(icon: Icons.edit, onPressed: () {}),
          ],
        ),
      ],
    );
  }
}

class VisitsTabContent extends StatelessWidget {
  final Visit? currentVisit;

  @visibleForTesting
  const VisitsTabContent({
    required this.currentVisit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CurrentVisitCard(currentVisit: currentVisit),
      ],
    );
  }
}

class CurrentVisitCard extends StatelessWidget {
  final Visit? currentVisit;

  @visibleForTesting
  const CurrentVisitCard({
    required this.currentVisit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _title = ContentCardTitle(
      text: 'Current visit',
      icon: Icons.date_range,
    );

    if (currentVisit == null) {
      return const ContentCard(
        title: _title,
        emptyState: Text(
          'The patient is currently not admitted.',
        ),
      );
    }

    return ContentCard(
      title: _title,
      info: [
        ContentCardInfo(key: 'Start', value: 'Friday, 19-11-2021, 07:23a.m.'),
        ContentCardInfo(key: 'Type', value: currentVisit!.type.toString()),
        // TODO: Render actual time of visit start
      ],
      buttons: [
        ContentCardButton(title: 'Print registration card', onPressed: () {}),
        ContentCardButton(title: 'Discharge', onPressed: () {}),
      ],
      icons: [
        ContentCardIcon(icon: Icons.edit, onPressed: () {}),
      ],
    );
  }
}

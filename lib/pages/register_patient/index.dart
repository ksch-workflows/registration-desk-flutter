import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../api/patient/patient.dart';
import '../../api/patient/patient_service.dart';
import '../../api/visit/visit_service.dart';
import '../../routing.dart';
import '../../widgets/scaffold/generic_panel.dart';
import '../../widgets/scaffold/index.dart';
import '../dashboard/index.dart';
import '../patient_details/index.dart';
import 'register_patient_bloc/register_patient_bloc.dart';
import 'register_patient_dialog/index.dart';

class RegisterPatientPage extends StatefulWidget {
  @override
  _RegisterPatientPageState createState() => _RegisterPatientPageState();
}

class _RegisterPatientPageState extends State<RegisterPatientPage> {
  List<Patient>? matchingPatients;
  bool isWaitingForHttpResponse = false;

  final ScrollController scrollController = ScrollController();
  final TextEditingController searchTermController = TextEditingController();
  final PatientService patientService = GetIt.I<PatientService>();
  final VisitService visitService = GetIt.I<VisitService>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterPatientBloc(),
      child: BlocListener<RegisterPatientBloc, RegisterPatientState>(
        listener: (context, state) {
          if (state is ClosingRegisterPatientDialog) {
            Navigator.pop(context);
            return;
          }
          if (state is NavigatingToPatientDetailsPage) {
            Navigator.push(
                context,
                DesktopPageRoute(
                    builder: (context) => PatientDetailsPage(state.patientId)));
            return;
          }
        },
        child: BlocBuilder<RegisterPatientBloc, RegisterPatientState>(
          builder: (context, state) {
            return DesktopScaffold(
              title: 'Register patient',
              child: GenericPanel(
                child: Column(
                  children: [
                    _buildActionRow(),
                    const SizedBox(height: 25),
                    _buildPatientTable(),
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    searchTermController.clear();
                    _showRegisterPatientDialog(context);
                  },
                  tooltip: 'Add new patient',
                  child: const Icon(Icons.add),
                ),
              ),
              onNavigateBack: () {
                Navigator.push(
                    context,
                    DesktopPageRoute(
                        builder: (context) => RegistrationDashboard()));
              },
            );
          },
        ),
      ),
    );
  }

  Future<RegisterPatientResult?> _showRegisterPatientDialog(
    BuildContext context,
  ) {
    var registerPatientBloc = context.read<RegisterPatientBloc>();
    return showDialog(
      context: context,
      builder: (context) {
        return LoaderOverlay(
          child: RegisterPatientDialog(
            onDialogClose: (result) {
              if (result != null) {
                context.loaderOverlay.show();
                registerPatientBloc.add(
                  NewPatientSaved(result.patient, result.visitType),
                );
              } else {
                registerPatientBloc.add(PatientRegistrationStopped());
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildPatientTable() {
    if (matchingPatients == null) {
      return Container();
    }
    if (matchingPatients!.isEmpty) {
      return const Text('No patients found.');
    }

    return Flexible(
      child: Row(
        children: [
          Expanded(
            child: Scrollbar(
              isAlwaysShown: matchingPatients!.length > 7,
              thickness: 8,
              controller: scrollController,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                controller: scrollController,
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text('OPD No.'),
                    ),
                    DataColumn(
                      label: Text('Name'),
                    ),
                    DataColumn(
                      label: Text('Location'),
                    ),
                    DataColumn(
                      label: Text('Last visit'),
                    ),
                  ],
                  rows: _buildTableRows(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DataRow> _buildTableRows() {
    return matchingPatients!
        .map((e) => DataRow(
              cells: [
                DataCell(Text(e.opdNumber ?? 'n/a')),
                DataCell(Text(e.name ?? 'n/a')),
                DataCell(Text(e.location ?? 'n/a')),
                DataCell(Text(e.lastVisit?.toString() ?? 'n/a')),
              ],
            ))
        .toList();
  }

  Row _buildActionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            width: 200,
            child: TextField(
              controller: searchTermController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Search patient...',
                suffixIcon: _searchPatientInputSuffixIcon(),
              ),
              onChanged: (value) async {
                List<Patient>? update;
                final normalizedValue = value.trim().toLowerCase();
                if (normalizedValue.isEmpty) {
                  update = null;
                } else {
                  setState(() {
                    isWaitingForHttpResponse = true;
                  });
                  update = await patientService.find(normalizedValue);
                }

                setState(() {
                  isWaitingForHttpResponse = false;
                  matchingPatients = update;
                });
              },
              autofocus: true,
            ),
          ),
        )
      ],
    );
  }

  Widget _searchPatientInputSuffixIcon() {
    if (isWaitingForHttpResponse) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 8,
            maxWidth: 8,
          ),
          child: const CircularProgressIndicator(),
        ),
      );
    } else {
      return Container(
        child: const Icon(Icons.search),
      );
    }
  }
}

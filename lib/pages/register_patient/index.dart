import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../api/patient/patient.dart';
import '../../api/patient/patient_service.dart';
import '../../api/visit/visit_service.dart';
import '../../context.dart';
import '../../routing.dart';
import '../../widgets/scaffold.dart';
import '../../widgets/test_bench.dart';
import '../dashboard/index.dart';
import 'register_patient_dialog/index.dart';

class RegisterPatientPage extends StatefulWidget {
  @override
  _RegisterPatientPageState createState() => _RegisterPatientPageState();
}

class _RegisterPatientPageState extends State<RegisterPatientPage> {
  List<Patient>? matchingPatients;

  final ScrollController scrollController = ScrollController();
  final TextEditingController searchTermController = TextEditingController();
  final PatientService? patientService = GetIt.I<PatientService>();
  final VisitService? visitService = GetIt.I<VisitService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      title: 'Register patient',
      body: Column(
        children: [
          _buildActionRow(),
          const SizedBox(height: 25),
          _buildPatientTable(),
        ],
      ),
      onNavigateBack: () {
        Navigator.push(context, WebPageRoute(builder: (context) => RegistrationDashboard()));
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          searchTermController.clear();
          final result = await showDialog(
              context: context,
              builder: (context) {
                return RegisterPatientDialog(
                  onDialogClose: (result) => Navigator.pop(context, result),
                );
              });
          if (result != null) {
            final createdPatient = patientService!.create(result.patient);
            visitService!.startVisit(createdPatient.id);
            print('Patient created: ${createdPatient.id}');
          }
        },
        tooltip: 'Add new patient',
        child: const Icon(Icons.add),
      ),
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
                DataCell(Text(e.opdNumber!)),
                DataCell(Text(e.name)),
                DataCell(Text(e.location)),
                DataCell(Text(e.lastVisit.toString())),
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
                suffixIcon: Container(
                  child: const Icon(Icons.search),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  final normalizedValue = value.trim().toLowerCase();
                  if (normalizedValue.isEmpty) {
                    matchingPatients = null;
                  } else {
                    matchingPatients = patientService!.find(normalizedValue);
                  }
                });
              },
              autofocus: true,
            ),
          ),
        )
      ],
    );
  }
}

void main() {
  createMockContext();

  runApp(
    TestBench(
      child: RegisterPatientPage(),
      isFullPage: true,
    ),
  );
}


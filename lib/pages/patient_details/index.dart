import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
          builder: (
            BuildContext context,
            AsyncSnapshot<PatientDetailsModel> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ListTile(
                          leading: const Icon(Icons.perm_identity),
                          title: Text('Identity'),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 40, 10),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  TextFormField(
                                    // controller: widget.nameController,
                                    // focusNode: initialFocus,
                                    decoration: const InputDecoration(
                                      labelText: "Patient's name",
                                      border: OutlineInputBorder(),
                                      hintText: "Please enter the patient's name",
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    // controller: widget.fatherNameController,
                                    decoration: const InputDecoration(
                                      labelText: "Father's name",
                                      border: OutlineInputBorder(),
                                      hintText: "Please enter the patient father's name, if applicable",
                                    ),
                                  ),
                                ],
                              ),

                            ],

                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () => {},
                                  child: Text('CAPTURE PHOTOGRAPH'),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {},
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ListTile(
                          leading: const Icon(Icons.event_note),
                          title: Text('Current visit'),
                        ),
                        Text(
                            'Patient has been admitted on XX-XX-XXXX with visit type XXX.'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () => {},
                                  child: Text('PRINT REGISTRATION CARD'),
                                ),
                                SizedBox(width: 15),
                                TextButton(
                                  onPressed: () => {},
                                  child: Text('DISCHARGE'),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {},
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
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

import 'package:ksch_dart_client/core.dart';
import 'package:ksch_dart_client/resources.dart';

import 'visit.dart';

// ignore: one_member_abstracts
abstract class VisitService {
  Future<Visit> startVisit(String patientId, VisitType type);
}

class VisitServiceImpl implements VisitService {
  final KschApi _api;

  VisitServiceImpl(this._api);

  @override
  Future<Visit> startVisit(String patientId, VisitType type) async {
    var response =
        await _api.patients(patientId).visits.startVisit(VisitType.OPD);
    var result = Visit(
      id: response.id,
      patientId: patientId,
      type: response.type,
    );
    print("[INFO] Started visit '${result.id}' for patient '$patientId'.");
    return result;
  }
}

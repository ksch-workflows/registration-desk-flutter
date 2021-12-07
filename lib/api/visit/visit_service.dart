import 'package:ksch_dart_client/core.dart';
import 'package:ksch_dart_client/resources.dart';

import 'visit.dart';

// ignore: one_member_abstracts
abstract class VisitService {
  Future<Visit> startVisit(String patientId, VisitType type);

  Future<Visit> get({required String patientId, required String visitId});
}

class VisitServiceImpl implements VisitService {
  final KschApi _api;

  VisitServiceImpl(this._api);

  @override
  Future<Visit> startVisit(String patientId, VisitType type) async {
    var response =
        await _api.patients(patientId).visits.startVisit(type);
    var result = Visit(
      id: response.id,
      patientId: patientId,
      type: response.type,
      timeStart: response.timeStart,
      opdNumber: response.opdNumber,
    );
    print("[INFO] Started visit '${result.id}' of type '${type.name}' for "
            "patient '$patientId'.");
    return result;
  }

  // TODO(test): This method needs a unit test
  @override
  Future<Visit> get({
    required String patientId,
    required String visitId,
  }) async {
    var response = await _api.patients(patientId).visits(visitId).get();
    return Visit(
      id: response.id,
      patientId: patientId,
      type: response.type,
      opdNumber: response.opdNumber,
      timeStart: response.timeStart,
    );
  }
}

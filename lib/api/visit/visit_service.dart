import 'package:ksch_dart_client/resources.dart';
import 'package:ksch_dart_client/src/client.dart';

import 'package:uuid/uuid.dart';

import 'visit.dart';

// ignore: one_member_abstracts
abstract class VisitService {
  Future<Visit> startVisit(String patientId, VisitType type);
}

class VisitServiceImpl implements VisitService {
  final KschApi _api;

  VisitServiceImpl(this._api);

  // TODO Make patientId required
  // TODO Add parameter for visit type
  @override
  Future<Visit> startVisit(String patientId, VisitType type) async {
    var response =
        await _api.patients(patientId).visits.startVisit(VisitType.OPD);
    return Visit(
      id: response.id,
      patientId: patientId,
      type: response.type,
    );
  }
}

class MockVisitService implements VisitService {
  @override
  Future<Visit> startVisit(String? patientId, VisitType type) {
    var result = Visit(
      id: const Uuid().v4(),
      patientId: patientId,
      type: type,
    );
    return Future.sync(() => result);
  }
}

import 'package:ksch_dart_client/src/client.dart';

import 'package:uuid/uuid.dart';

import 'visit.dart';

// ignore: one_member_abstracts
abstract class VisitService {
  Future<Visit> startVisit(String? patientId);
}

class VisitServiceImpl implements VisitService {

  final KschApi _api;

  VisitServiceImpl(this._api);

  @override
  Future<Visit> startVisit(String? patientId) {
    throw UnimplementedError();
  }
}

class MockVisitService implements VisitService {
  @override
  Future<Visit> startVisit(String? patientId) {
    var result = Visit(
      id: const Uuid().v4(),
      patientId: patientId,
    );
    return Future.sync(() => result);
  }
}

import 'package:ksch_dart_client/resources.dart';
import 'package:uuid/uuid.dart';

import '../../api/visit/visit.dart';
import '../../api/visit/visit_service.dart';

class DummyVisitService implements VisitService {
  late Visit visitResponse;

  @override
  Future<Visit> startVisit(String patientId, VisitType type) async {
    var result = Visit(
      id: const Uuid().v4(),
      patientId: patientId,
      type: type,
      timeStart: DateTime.now(),
      opdNumber: '10-1110132'
    );
    visitResponse = result;
    return result;
  }

  @override
  Future<Visit> get({
    required String patientId,
    required String visitId,
  }) async {
    return visitResponse;
  }
}

import 'package:ksch_dart_client/resources.dart';
import 'package:uuid/uuid.dart';

import '../../api/visit/visit.dart';
import '../../api/visit/visit_service.dart';

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

import "package:uuid/uuid.dart";

import "visit.dart";

// ignore: one_member_abstracts
abstract class VisitService {
  Visit startVisit(String patientId);
}

class MockVisitService implements VisitService {
  @override
  Visit startVisit(String patientId) {
    return Visit(
      id: Uuid().v4(),
      patientId: patientId,
    );
  }
}

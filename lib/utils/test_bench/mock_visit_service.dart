import 'package:ksch_dart_client/resources.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

import '../../api/visit/visit.dart';
import '../../api/visit/visit_service.dart';

class MockVisitService extends Mock implements VisitService {}

class InMemoryVisitService implements VisitService {
  @override
  Future<Visit> startVisit(String? patientId, VisitType type) {
    var result = Visit(
      id: const Uuid().v4(),
      patientId: patientId,
      type: type,
    );
    return Future.sync(() => result);
  }

  @override
  Future<Visit> get({required String patientId, required String visitId}) {
    throw UnimplementedError();
  }
}

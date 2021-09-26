import 'dart:convert';

import 'package:ksch_dart_client/core.dart';
import 'package:ksch_dart_client/resources.dart';
import 'package:nock/nock.dart';
import 'package:registration_desk/api/visit/visit_service.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

import '../../util/request_matcher.dart';

const uuidPattern =
    r'[0-9a-fA-F]{8}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{12}';

void main() {
  late VisitServiceImpl visitService;

  setUpAll(nock.init);

  setUp(() {
    nock.cleanAll();

    visitService = VisitServiceImpl(KschApi('http://localhost'));
  });

  test('Should start visit', () async {
    const expectedVisitType = VisitType.IPD;
    final expectedId = const Uuid().v4();
    const expectedOpdNumber = '10-2342';
    final expectedTimeStart = DateTime.now();

    givenStartVisitResponse(ExampleVisitResponsePayload(
      id: expectedId,
      visitType: expectedVisitType,
      timeStart: expectedTimeStart,
      opdNumber: expectedOpdNumber,
    ));
    var patientId = const Uuid().v4();

    var visit = await visitService.startVisit(patientId, expectedVisitType);

    expect(visit, isNotNull);
    expect(visit.id, equals(expectedId));
    expect(visit.type, equals(expectedVisitType));
  });
}

void givenStartVisitResponse(dynamic body) {
  nock('http://localhost')
      .post(RegExp('^/api/patients/$uuidPattern/visits'), any())
        ..reply(201, json.encode(body));
}

class ExampleVisitResponsePayload extends VisitResponsePayload {
  ExampleVisitResponsePayload({
    required String id,
    required VisitType visitType,
    required String opdNumber,
    required DateTime timeStart,
  }) : super(
          id: id,
          type: visitType,
          opdNumber: opdNumber,
          timeStart: timeStart,
        );
}

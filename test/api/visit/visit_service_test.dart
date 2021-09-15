import 'package:ksch_dart_client/core.dart';
import 'package:ksch_dart_client/resources.dart';
import 'package:nock/nock.dart';
import 'package:registration_desk/api/visit/visit_service.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

import 'dart:convert';

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
    givenStartVisitResponse(ExampleVisitResponsePayload());
    var patientId = const Uuid().v4();

    var visit = await visitService.startVisit(patientId);

    expect(visit, isNotNull);

    // TODO Test that request contains required type
    // TODO Test that response contains OPD number
    // TODO Test that response contains resource ID
    // TODO Test that response contains resource ID
  });
}

void givenStartVisitResponse(dynamic body) {
  nock('http://localhost')
      .post(RegExp('^/api/patients/$uuidPattern/visits'), any())
    ..reply(201, json.encode(body));
}

class ExampleVisitResponsePayload extends VisitResponsePayload {
  ExampleVisitResponsePayload()
      : super(
          id: const Uuid().v4(),
          type: VisitType.OPD,
          opdNumber: '12-1234',
          timeStart: DateTime.now(),
        );
}

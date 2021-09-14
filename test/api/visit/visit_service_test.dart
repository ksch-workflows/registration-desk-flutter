import 'package:ksch_dart_client/core.dart';
import 'package:nock/nock.dart';
import 'package:registration_desk/api/visit/visit_service.dart';
import 'package:test/test.dart';

import '../../util/request_matcher.dart';

void main() {
  late VisitServiceImpl visitService;

  setUpAll(nock.init);

  setUp(() {
    nock.cleanAll();

    visitService = VisitServiceImpl(KschApi('http://localhost'));
  });

  test('Should start visit', () async {

  });
}

void givenCreatePatientResponse(dynamic body) {
  nock('http://localhost').post('/api/patients', any())..reply(200, body);
}

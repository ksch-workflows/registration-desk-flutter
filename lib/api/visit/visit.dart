import 'package:ksch_dart_client/resources.dart';

class Visit {
  final String id;
  final String patientId;
  final String opdNumber;
  final DateTime timeStart;
  final VisitType type;

  Visit({
    required this.id,
    required this.patientId,
    required this.opdNumber,
    required this.timeStart,
    required this.type,
  });
}

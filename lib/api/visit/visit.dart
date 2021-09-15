import 'package:ksch_dart_client/resources.dart';

class Visit {
  final String? id;
  final String? patientId;
  final VisitType type;

  Visit({
    this.id,
    this.patientId,
    required this.type,
  });
}

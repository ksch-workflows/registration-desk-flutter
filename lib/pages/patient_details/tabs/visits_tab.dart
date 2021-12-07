import 'package:flutter/material.dart';

import '../../../api/visit/visit.dart';
import 'current_visit_cart.dart';

class VisitsTabContent extends StatelessWidget {
  final Visit? currentVisit;

  const VisitsTabContent({
    required this.currentVisit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CurrentVisitCard(currentVisit: currentVisit),
      ],
    );
  }
}

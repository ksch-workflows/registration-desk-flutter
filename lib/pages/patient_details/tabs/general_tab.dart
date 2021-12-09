import 'package:flutter/material.dart';

import '../../../api/patient/patient.dart';
import '../../../widgets/content_card/index.dart';

class GeneralTabContent extends StatelessWidget {
  final Patient patient;

  const GeneralTabContent({
    required this.patient,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContentCard(
          title: const ContentCardTitle(
            text: 'Identity',
            icon: Icons.badge,
          ),
          info: [
            ContentCardInfo(
              key: 'Name',
              value: patient.name ?? 'unknown',
            ),
            ContentCardInfo(
              key: 'Father\'s name',
              value: patient.fatherName ?? 'unknown',
            ),
          ],
        ),
      ],
    );
  }
}

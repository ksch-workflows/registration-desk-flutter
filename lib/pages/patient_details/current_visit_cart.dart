import 'package:flutter/material.dart';
import 'package:ksch_dart_client/resources.dart';
import 'package:ksch_dart_client/resources.dart';

import '../../api/visit/visit.dart';
import '../../utils/time.dart';
import '../../widgets/content_card/index.dart';

class CurrentVisitCard extends StatelessWidget {
  final Visit? currentVisit;

  const CurrentVisitCard({
    required this.currentVisit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _title = ContentCardTitle(
      text: 'Current visit',
      icon: Icons.date_range,
    );

    if (currentVisit == null) {
      return const ContentCard(
        title: _title,
        emptyState: Text(
          'The patient is currently not admitted.',
        ),
      );
    }

    return ContentCard(
      title: _title,
      info: [
        ContentCardInfo(
          key: 'Start',
          value: currentVisit!.timeStart.toFormattedString(),
        ),
        ContentCardInfo(
          key: 'Type',
          value: Name.of(currentVisit!.type),
        ),
      ],
      buttons: [
        ContentCardButton(title: 'Print registration card', onPressed: () {}),
        ContentCardButton(title: 'Discharge', onPressed: () {}),
      ],
      icons: [
        ContentCardIcon(icon: Icons.edit, onPressed: () {}),
      ],
    );
  }
}

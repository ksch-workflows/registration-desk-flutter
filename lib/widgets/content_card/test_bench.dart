// ignore_for_file: prefer_relative_imports

import 'package:flutter/material.dart';
import 'package:registration_desk/widgets/content_card/content_card.dart';
import 'package:registration_desk/widgets/info_table/info_table.dart';

import 'package:registration_desk/widgets/test_bench.dart';

void main() {
  runApp(
    TestBench(
      pageSize: Size(1500, 800),
      child: Container(
          child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: ContentCard(
            title: 'Identity',
            icon: Icons.person_outline,
            info: [
              ContentCardInfo(key: 'Patient\'s name', value: null),
              ContentCardInfo(key: 'Patient\'s father name', value: 'John Doe'),
            ],
            actions: [
              ContentCardAction(title: 'Test', onPressed: () => {}),
              ContentCardAction(title: 'Test 2', onPressed: () => {}),
            ],
          ),
        ),
      )),
    ),
  );
}

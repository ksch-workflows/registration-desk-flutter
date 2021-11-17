// ignore_for_file: prefer_relative_imports

import 'package:flutter/material.dart';
import 'package:registration_desk/widgets/content_card/content_card.dart';
import 'package:registration_desk/widgets/info_table/info_table.dart';

import 'package:registration_desk/widgets/test_bench.dart';

void main() {
  runApp(
    TestBench(
      pageSize: Size(1500, 800),
      child: Container(child: Padding(  
        padding: const EdgeInsets.all(30.0),
        child: ContentCard(info : [
          Info(key: 'Patient\'s name', value: null),
          Info(key: 'Patient\'s father name', value: 'John Doe'),
        ]),
      )),
    ),
  );
}

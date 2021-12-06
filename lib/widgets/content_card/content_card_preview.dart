// ignore_for_file: prefer_relative_imports, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:registration_desk/widgets/content_card/index.dart';
import 'package:registration_desk/widgets/test_bench.dart';

void main() {
  var widget = ContentCard(
    title: ContentCardTitle(
      text: 'Widget test',
      icon: Icons.house,
    ),
    buttons: [
      ContentCardButton(title: 'Click me', onPressed: () => {}),
    ],
  );

  runApp(
    TestBench(
      pageSize: const Size(800, 600),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: widget,
          ),
        ),
      ),
    ),
  );
}

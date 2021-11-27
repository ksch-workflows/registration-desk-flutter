// ignore_for_file: prefer_relative_imports, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:registration_desk/widgets/test_bench.dart';

import 'generic_panel.dart';
import 'scaffold.dart';

void main() {
  var panel = GenericPanel(
    child: Text('Hello, web scaffold'),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        // Add your onPressed code here!
      },
      child: const Icon(Icons.navigation),
      backgroundColor: Colors.green,
    ),
  );

  var widget = DesktopScaffold(
    title: 'Example',
    child: panel,
  );

  runApp(
    TestBench(
      child: widget,
    ),
  );
}

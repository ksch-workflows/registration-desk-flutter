import "package:flutter/material.dart";

/// Enables writing tests for widgets which depend upon the MaterialApp widget.
class TestApp extends StatelessWidget {
  final Widget testSubject;

  const TestApp(this.testSubject);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: testSubject,
      ),
    );
  }
}

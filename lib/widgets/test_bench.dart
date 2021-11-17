import 'package:flutter/material.dart';

class TestBench extends StatelessWidget {
  final Widget child;
  final Size? pageSize;

  const TestBench({
    required this.child,
    this.pageSize,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Bench',
      home: pageSize == null ? child : wrapComponentInScaffold(),
      theme: ThemeData(fontFamily: 'Roboto'),
    );
  }

  Scaffold wrapComponentInScaffold() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Bench'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(100.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: pageSize!.width,
            maxHeight: pageSize!.height,
          ),
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Center(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

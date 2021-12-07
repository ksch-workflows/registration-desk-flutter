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
      home:
          pageSize == null ? wrapChildInMaterial() : wrapComponentInScaffold(),
      theme: ThemeData(fontFamily: 'Roboto'),
    );
  }

  Material wrapChildInMaterial() {
    return Material(child: child);
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

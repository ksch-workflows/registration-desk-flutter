import "package:flutter/material.dart";


class TestBench extends StatelessWidget {
  final Widget child;
  final bool isFullPage;
  final Size? pageSize;

  const TestBench({required this.child, this.isFullPage = false, this.pageSize}) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test Bench",
      home: isFullPage ? child : wrapComponentInScaffold(),
      theme: ThemeData(fontFamily: "Roboto"),
    );
  }

  Scaffold wrapComponentInScaffold() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Bench"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(100.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 800,
            maxHeight: 600,
          ),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
            ),
            child: Center(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

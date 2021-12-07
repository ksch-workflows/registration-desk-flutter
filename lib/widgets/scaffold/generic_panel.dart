import 'package:flutter/material.dart';

class GenericPanel extends StatelessWidget {
  final Widget child;
  final Widget? floatingActionButton;

  const GenericPanel({
    required this.child,
    this.floatingActionButton,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            child: floatingActionButton,
          ),
          Expanded(
            child: child,
          ),
          const SizedBox(
            width: 100,
          ),
        ],
      ),
    );
  }
}

import "package:flutter/material.dart";

class IndexBubble extends StatelessWidget {
  final int? index;
  final Color? foregroundColor;
  final Color? backgroundColor;

  const IndexBubble({
    this.index,
    this.foregroundColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          (index! + 1).toString(),
          style: TextStyle(
            color: foregroundColor,
          ),
        ),
      ),
    );
  }
}

class ActiveIndexBubble extends StatelessWidget {
  final int index;

  const ActiveIndexBubble(this.index);

  @override
  Widget build(BuildContext context) {
    return IndexBubble(
      index: index,
      foregroundColor: Theme.of(context).colorScheme.onSecondary,
      backgroundColor: Theme.of(context).accentColor,
    );
  }
}

class InactiveIndexBubble extends StatelessWidget {
  final int index;

  const InactiveIndexBubble(this.index);

  @override
  Widget build(BuildContext context) {
    return IndexBubble(
      index: index,
      backgroundColor: Theme.of(context).buttonColor,
      foregroundColor: Theme.of(context).colorScheme.onSurface,
    );
  }
}

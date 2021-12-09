import 'package:flutter/material.dart';

import '../constants.dart';

class PrimaryButton extends StatelessWidget {
  final Key? buttonKey;
  final String text;
  final VoidCallback? onPressed;
  final String? tooltip;
  final double? minWidth;

  const PrimaryButton({
    this.buttonKey,
    required this.text,
    required this.onPressed,
    this.tooltip,
    this.minWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: minWidth ?? 0),
      child: Tooltip(
        message: tooltip,
        child: ElevatedButton(
          key: buttonKey,
          child: Text(text),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final Key? buttonKey;
  final String text;
  final VoidCallback? onPressed;
  final String? tooltip;
  final double? minWidth;

  const SecondaryButton({
    this.buttonKey,
    required this.text,
    required this.onPressed,
    this.tooltip,
    this.minWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: minWidth ?? 0),
      child: Tooltip(
        message: tooltip,
        child: ElevatedButton(
          key: buttonKey,
          child: Text(
            text,
            style: const TextStyle(
              color: AppLayout.secondaryButtonTextColor,
            ),
          ),
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: AppLayout.secondaryButtonBackgroundColor,
          ),
        ),
      ),
    );
  }
}

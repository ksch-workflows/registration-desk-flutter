import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final Function onBack;
  final Function onCancel;
  final Function onContinue;
  final bool isLastStep;

  const ActionButtons({
    required this.onBack,
    required this.onCancel,
    required this.onContinue,
    this.isLastStep = false,
  });

  @override
  Widget build(BuildContext context) {
    return _ButtonRow(
      [
        FocusTraversalOrder(
          order: const NumericFocusOrder(2),
          child: _backButton(),
        ),
        Expanded(
          child: Container(),
        ),
        FocusTraversalOrder(
          order: const NumericFocusOrder(3),
          child: _cancelButton(context),
        ),
        const SizedBox(
          width: 20,
        ),
        FocusTraversalOrder(
          order: const NumericFocusOrder(1),
          child: _continueButton(context),
        ),
      ],
    );
  }

  Widget _continueButton(BuildContext context) {
    return Tooltip(
      message: 'Go to the next step',
      child: ElevatedButton(
        key: const ValueKey('continueButton'),
        child: Text(
          isLastStep ? 'Save' : 'Continue',
        ),
        onPressed: onContinue as void Function()?,
      ),
    );
  }

  Widget _cancelButton(BuildContext context) {
    return ElevatedButton(
      key: const ValueKey('cancelButton'),
      child: const Text('Cancel', style: TextStyle(color: Colors.black)),
      onPressed: onCancel as void Function()?,
      style: ElevatedButton.styleFrom(
        primary: Colors.grey[350],
      ),
    );
  }

  Widget _backButton() {
    return Tooltip(
      message: 'Go back to the previous step.',
      child: ElevatedButton(
        key: const ValueKey('backButton'),
        child: const Text('Back', style: TextStyle(color: Colors.black)),
        onPressed: onBack as void Function()?,
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[350],
        ),
      ),
    );
  }
}

class _ButtonRow extends StatelessWidget {
  final List<Widget> children;

  const _ButtonRow(this.children);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: FocusTraversalGroup(
        policy: OrderedTraversalPolicy(),
        child: Row(
          children: children,
        ),
      ),
    );
  }
}

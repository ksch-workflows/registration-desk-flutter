import 'package:flutter/material.dart';

import '../../buttons.dart';

class ActionButtons extends StatelessWidget {
  final Function onBack;
  final Function onCancel;
  final Function onContinue;
  final bool isFirstStep;
  final bool isLastStep;

  const ActionButtons({
    required this.onBack,
    required this.onCancel,
    required this.onContinue,
    this.isFirstStep = false,
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
    return PrimaryButton(
      key: const ValueKey('continueButton'),
      tooltip: 'Go to the next step',
      text: isLastStep ? 'Save' : 'Continue',
      onPressed: onContinue as void Function()?,
      minWidth: 120,
    );
  }

  Widget _cancelButton(BuildContext context) {
    return SecondaryButton(
      tooltip: 'Close the dialog and discard all entries',
      key: const ValueKey('cancelButton'),
      text: 'Cancel',
      onPressed: onCancel as void Function()?,
      minWidth: 120,
    );
  }

  Widget _backButton() {
    if (isFirstStep) {
      return Container();
    }
    return SecondaryButton(
      tooltip: 'Go back to the previous step.',
      key: const ValueKey('backButton'),
      text: 'Back',
      onPressed: onBack as void Function()?,
      minWidth: 120,
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

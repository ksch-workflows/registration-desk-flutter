import "package:flutter/material.dart";

class ActionButtons extends StatelessWidget {
  final Function onBack;
  final Function onCancel;
  final Function onContinue;
  final bool isLastStep;

  const ActionButtons({
    @required this.onBack,
    @required this.onCancel,
    @required this.onContinue,
    this.isLastStep = false,
  })  : assert(onBack != null),
        assert(onCancel != null),
        assert(onContinue != null);

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
          child: _cancelButton(),
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
      message: "Go to the next step.",
      child: RaisedButton(
        key: const ValueKey("continueButton"),
        color: Theme.of(context).accentColor,
        child: Text(
          isLastStep ? "Save" : "Continue",
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        ),
        onPressed: onContinue,
      ),
    );
  }

  Widget _cancelButton() {
    return RaisedButton(
      key: const ValueKey("cancelButton"),
      child: const Text("Cancel"),
      onPressed: onCancel,
    );
  }

  Widget _backButton() {
    return Tooltip(
      message: "Go back to the previous step.",
      child: RaisedButton(
        key: const ValueKey("backButton"),
        child: const Text("Back"),
        onPressed: onBack,
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

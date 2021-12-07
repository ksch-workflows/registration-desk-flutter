import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../pages/dashboard/index.dart';
import '../../routing.dart';

class DesktopScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final Function? onNavigateBack;

  const DesktopScaffold({
    required this.title,
    required this.child,
    this.onNavigateBack,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          child: Column(
            children: [
              _AppBar(
                title: title,
                onNavigateBack: onNavigateBack,
              ),
              // TODO(test): Should render patient search results.
              // Without the constrained box, the test should fail.
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: constraints.maxHeight - AppLayout.appBarHeight,
                ),
                child: child,
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _AppBar extends StatelessWidget {
  final String title;
  final Function? onNavigateBack;

  const _AppBar({
    required this.title,
    this.onNavigateBack,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Move color definitions into "constants.dart"
    final appBarColor = Theme.of(context).primaryColor;
    final buttonColor = Colors.grey[350]!;

    return Container(
      color: appBarColor,
      height: AppLayout.appBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _navigationWidgets(context, buttonColor),
          _actionButtons(buttonColor),
        ],
      ),
    );
  }

  IconButton _homeButton(BuildContext context, Color? color) {
    return IconButton(
      icon: Icon(Icons.home, color: color),
      onPressed: () => Navigator.push(
        context,
        DesktopPageRoute(builder: (context) => RegistrationDashboard()),
      ),
    );
  }

  Row _navigationWidgets(BuildContext context, Color buttonColor) {
    return Row(
      children: [
        _homeButton(context, buttonColor),
        _backButton(buttonColor),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            title,
            key: const ValueKey('pageName'),
            style: const TextStyle(
              color: Colors.white,
              //fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        )
      ],
    );
  }

  Row _actionButtons(Color color) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.settings,
            color: color,
          ),
          onPressed: () => print('TODO: Open settings dialog'),
        ),
        IconButton(
          icon: Icon(
            Icons.logout,
            color: color,
          ),
          onPressed: () => print('TODO: Trigger logout'),
        ),
      ],
    );
  }

  Widget _backButton(Color buttonColor) {
    if (onNavigateBack != null) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        color: buttonColor,
        onPressed: onNavigateBack as void Function()?,
      );
    } else {
      return const SizedBox(
        width: 40,
      );
    }
  }
}

import 'package:flutter/material.dart';

import '../pages/dashboard/index.dart';
import '../routing.dart';
import 'test_bench.dart';

class WebScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final Function? onNavigateBack;

  const WebScaffold({
    required this.title,
    required this.body,
    this.onNavigateBack,
    this.floatingActionButton,
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
              Container(
                color: Colors.grey[200],
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PatientSummary(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: ConstrainedBox(
                          constraints: BoxConstraints.loose(Size(1200, 50)),
                          child: DefaultTabController(
                            length: 3,
                            child: TabBar(
                              // indicatorColor: Colors.red,
                              isScrollable: true,
                              tabs: [
                                Tab(
                                  child: Text(
                                    'General',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'Visits',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'Billing',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              _buildBodyWrapper(constraints)
            ],
          ),
        );
      }),
    );
  }

  Row _buildBodyWrapper(BoxConstraints constraints) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          child: floatingActionButton,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 500,
            maxWidth: 1200,
          ),
          child: body,
        ),
        const SizedBox(
          width: 100,
        ),
      ],
    );
  }
}

class PatientSummary extends StatelessWidget {
  const PatientSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'unknown',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
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
    final appBarColor = Theme.of(context).primaryColor;
    final buttonColor = Colors.grey[350]!;

    return Container(
      color: appBarColor,
      height: 55,
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
        WebPageRoute(builder: (context) => RegistrationDashboard()),
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

void main() {
  runApp(
    TestBench(
      child: WebScaffold(
        title: 'Hello',
        body: Row(
          children: const [
            Text('Hello, Test Bench!'),
          ],
        ),
      ),
    ),
  );
}

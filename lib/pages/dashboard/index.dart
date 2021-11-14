import 'package:flutter/material.dart';

import '../../routing.dart';
import '../../widgets/scaffold/scaffold.dart';
import '../../widgets/test_bench.dart';
import '../register_patient/index.dart';

class RegistrationDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      title: 'Dashboard',
      body: Align(
        alignment: Alignment.topLeft,
        child: Container(
          padding: const EdgeInsets.fromLTRB(100, 30, 0, 0),
          child: Wrap(
            alignment: WrapAlignment.start,
            children: const [
              TileButton(icon: Icons.menu_book, title: 'Register patient'),
            ],
          ),
        ),
      ),
    );
  }
}

class TileButton extends StatelessWidget {
  final IconData icon;
  final String title;

  const TileButton({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
      child: InkWell(
        child: Ink(
          width: 200,
          height: 200,
          color: Colors.grey,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(
                  icon,
                  size: 100,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(title),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            WebPageRoute(builder: (context) => RegisterPatientPage()),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(
    TestBench(
      child: RegistrationDashboard(),
    ),
  );
}

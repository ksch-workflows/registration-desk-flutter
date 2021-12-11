import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../routing.dart';
import '../../widgets/scaffold/generic_panel.dart';
import '../../widgets/scaffold/index.dart';
import '../../widgets/test_bench.dart';
import '../register_patient/index.dart';

const double _kTileFontSize = 20;

class RegistrationDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DesktopScaffold(
      title: 'Dashboard',
      child: GenericPanel(
        child: Align(
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
    return InkWell(
      child: Ink(
        width: 220,
        height: 220,
        color: AppLayout.secondaryButtonBackgroundColor,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 100,
                ),
                const SizedBox(height: 50),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppLayout.secondaryButtonTextColor,
                    fontSize: _kTileFontSize,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          DesktopPageRoute(builder: (context) => RegisterPatientPage()),
        );
      },
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

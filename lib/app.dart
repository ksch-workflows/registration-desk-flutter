import 'package:flutter/material.dart';

import 'pages/dashboard/index.dart';

class RegistrationDeskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration',
      home: RegistrationDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

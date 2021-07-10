import 'package:flutter/material.dart';

import 'context.dart';
import 'pages/dashboard/index.dart';

void main() {
  // initialiseContext('https://ksch-workflows-306713.ey.r.appspot.com'); // TODO Add deployment URL to GitHub secrets. Then it should be only used for the live system.
  initialiseContext('http://localhost:8080');

  runApp(
    MaterialApp(
      title: 'Registration',
      home: RegistrationDashboard(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

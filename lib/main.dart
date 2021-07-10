import 'package:flutter/material.dart';

import 'context.dart';
import 'pages/dashboard/index.dart';

void main() {
  createMockContext();

  runApp(
    MaterialApp(
      title: 'Registration',
      home: RegistrationDashboard(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

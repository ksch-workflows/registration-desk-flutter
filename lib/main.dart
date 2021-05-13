import "package:flutter/material.dart";

import "context.dart";
import "ui/dashboard/dashboard.dart";

void main() {
  createMockContext();

  runApp(
    MaterialApp(
      title: "Registration",
      home: RegistrationDashboard(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

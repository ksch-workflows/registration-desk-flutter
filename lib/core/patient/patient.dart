import "package:flutter/material.dart";

class Patient {
  final String id;
  final String opdNumber;
  final String name;
  final String fatherName;
  final String location;
  final DateTime lastVisit;

  Patient({
    this.id,
    this.opdNumber,
    @required this.name,
    this.fatherName,
    @required this.location,
    this.lastVisit,
  });
}

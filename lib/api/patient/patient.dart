class Patient {
  final String? id;
  final String? opdNumber;
  final String? name;
  final String? fatherName;
  final String? location; // TODO Rename to "residentialAddress"
  final DateTime? lastVisit;

  Patient({
    this.id,
    this.opdNumber,
    this.name,
    this.fatherName,
    this.location,
    this.lastVisit,
  });
}

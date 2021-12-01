import 'package:flutter/material.dart';

class InfoTable extends StatelessWidget {
  final List<Info> entries;

  const InfoTable(this.entries, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: entries
              .map((entry) => entry.key)
              .map((key) => Text('$key:'))
              .toList(),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: entries
              .map((entry) => entry.value)
              .map((value) => Text(value!))
              .toList(),
        ),
      ],
    );
  }
}

class Info {
  final String key;
  final String? value;

  Info({required this.key, this.value});
}

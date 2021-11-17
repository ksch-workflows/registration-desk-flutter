import 'package:flutter/material.dart';
import 'package:registration_desk/widgets/info_table/info_table.dart';

class ContentCard extends StatefulWidget {

  final List<Info> info;

  const ContentCard({required this.info, Key? key}) : super(key: key);

  @override
  State<ContentCard> createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {

  List<TextEditingController> infoTextControllers = [];

  late TextEditingController patientNameController;
  late TextEditingController patientFatherNameController;

  @override
  void initState() {

    for (var i in widget.info) {
      var c = TextEditingController();
      if (i.value != null) {
        c.text = i.value!;
      } else {
        c.text = 'unknown';
      }
      infoTextControllers.add(c);
    }
    super.initState();
  }

  @override
  void dispose() {
    for (var c in infoTextControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListTile(
            leading: const Icon(Icons.perm_identity),
            title: Text('Identity'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 40, 10),
            child: Column(
              children: [
                Column(
                  children: [
                    TextField(
                      readOnly: true,
                      controller: infoTextControllers[0],
                      decoration: const InputDecoration(
                        labelText: "Patient's name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: infoTextControllers[1],
                      decoration: const InputDecoration(
                        labelText: "Father's name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () => {},
                    child: Text('CAPTURE PHOTOGRAPH'),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {},
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

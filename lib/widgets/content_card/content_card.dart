import 'package:flutter/material.dart';
import '../info_table/info_table.dart';

class ContentCard extends StatelessWidget {
  final List<Info> info;

  const ContentCard({required this.info, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 10, 5),
              child: ListTile(
                leading: Icon(Icons.perm_identity, size: 50),
                title: Text('Identity'),
              ),
            ),
            _InfoTextFields(info: info),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 5, 10),
              child: Row(
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                        child: IconButton(
                          icon: const Icon(Icons.delete, size: 25),
                          onPressed: () {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            size: 24,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTextFields extends StatefulWidget {
  final List<Info> info;

  const _InfoTextFields({required this.info, Key? key}) : super(key: key);

  @override
  _InfoTextFieldsState createState() => _InfoTextFieldsState();
}

class _InfoTextFieldsState extends State<_InfoTextFields> {
  List<TextField> infoTextFields = [];
  List<TextEditingController> infoTextControllers = [];

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
      var f = TextField(
        readOnly: true,
        controller: c,
        decoration: InputDecoration(
          labelText: i.key,
          border: const OutlineInputBorder(),
        ),
      );
      infoTextFields.add(f);
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
    if (infoTextFields.isEmpty) {
      return Container();
    }
    var children = <Widget>[];
    for (var i = 0; i < infoTextFields.length; i++) {
      children.add(infoTextFields[i]);
      if (i + 1 < infoTextFields.length) {
        children.add(const SizedBox(height: 20));
      }
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 15, 40, 10),
      child: Column(children: children),
    );
  }
}

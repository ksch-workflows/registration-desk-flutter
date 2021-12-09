import 'package:flutter/material.dart';

class ContentCard extends StatelessWidget {
  final ContentCardTitle title;
  final List<ContentCardInfo> info;
  final List<ContentCardButton>? buttons;
  final List<ContentCardIcon>? icons;
  final Widget? emptyState;

  const ContentCard({
    required this.title,
    this.info = const [],
    this.buttons,
    this.icons,
    this.emptyState,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Card(
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
              child: ListTile(
                leading: Icon(title.icon, size: 50),
                title: Text(title.text),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 15, 40, 20),
              child: info.isNotEmpty
                  ? _InfoTextFields(info: info)
                  : _buildEmptyState(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 5, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _Buttons(buttons),
                  _Icons(icons),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    if (emptyState != null) {
      return emptyState!;
    } else {
      return Container();
    }
  }
}

class ContentCardTitle {
  final String text;
  final IconData icon;

  const ContentCardTitle({required this.text, required this.icon});
}

class ContentCardInfo {
  final String key;
  final String? value;

  ContentCardInfo({required this.key, this.value});
}

class ContentCardButton {
  final String title;
  final VoidCallback? onPressed;

  ContentCardButton({required this.title, required this.onPressed});
}

class ContentCardIcon {
  final IconData icon;
  final VoidCallback? onPressed;

  ContentCardIcon({required this.icon, required this.onPressed});
}

class _Buttons extends StatelessWidget {
  final List<ContentCardButton>? buttons;

  const _Buttons(this.buttons, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (buttons == null) {
      return Container();
    }
    return Row(
      children: buttons!
          .map((e) => TextButton(
                onPressed: e.onPressed,
                child: Text(e.title.toUpperCase()),
              ))
          .toList(),
    );
  }
}

class _Icons extends StatelessWidget {
  final List<ContentCardIcon>? icons;

  const _Icons(this.icons, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (icons == null) {
      return Container(height: 15);
    }
    return Row(
      children: icons!
          .map((e) => Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                child: IconButton(
                  icon: Icon(e.icon, size: 25),
                  onPressed: e.onPressed,
                ),
              ))
          .toList(),
    );
  }
}

class _InfoTextFields extends StatefulWidget {
  final List<ContentCardInfo> info;

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
    return Column(children: children);
  }
}

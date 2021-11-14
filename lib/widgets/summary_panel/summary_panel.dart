import 'package:flutter/material.dart';
import 'package:registration_desk/widgets/tab_selection_bloc/tab_selection_bloc.dart';

class SummaryPanel extends StatelessWidget {
  final TabSelectionBloc tabSelectionBloc;
  final List<SummaryPanelTab> tabs;

  const SummaryPanel({
    required this.tabs,
    required this.tabSelectionBloc,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SummaryPanelTab extends StatelessWidget {
  final String title;
  final Widget content;

  const SummaryPanelTab({
    required this.title,
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

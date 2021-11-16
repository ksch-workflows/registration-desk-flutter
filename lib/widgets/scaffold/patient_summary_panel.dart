import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_desk/api/patient/patient.dart';
import 'package:registration_desk/widgets/tab_selection_bloc/tab_selection_bloc.dart';

class DetailsPage extends StatefulWidget {
  final Patient patient;
  final TabSelectionBloc tabSelectionBloc;
  final List<SummaryPanelTab> tabs;

  const DetailsPage({
    required this.patient,
    required this.tabs,
    required this.tabSelectionBloc,
    Key? key,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  late int selectedTab;
  late TabController tabController;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: widget.tabSelectionBloc.state,
    );
    tabController.addListener(() {
      triggerTabSelectionEvent();
      setState(() {
        scrollController.jumpTo(0);
      });
    });
    selectedTab = widget.tabSelectionBloc.state;
    triggerTabSelectionEvent();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            color: Colors.grey[300],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PatientSummary(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: ConstrainedBox(
                      constraints: BoxConstraints.loose(Size(1200, 500)),
                      child: TabBar(
                        controller: tabController,
                        // indicatorColor: Colors.red,
                        isScrollable: true,
                        tabs: widget.tabs
                            .map((t) => Tab(
                                  child: Text(
                                    t.title,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<TabSelectionBloc, int>(
              builder: (context, state) {
                return Scrollbar(
                  isAlwaysShown: false,
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(100, 50, 100, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: widget.tabs[state].child,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void triggerTabSelectionEvent() {
    widget.tabSelectionBloc.add(TabSelectionChanged(tabController.index));
  }
}

class SummaryPanelTab {
  final String title;
  final Widget child;

  const SummaryPanelTab({
    required this.title,
    required this.child,
  });
}

class PatientSummary extends StatelessWidget {
  const PatientSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      // decoration: BoxDecoration(
      //   border: Border.all(),
      // ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(100, 20, 100, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'unknown',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      InfoTable([
                        InfoTableEntry(key: 'Father\'s name', value: 'unknown'),
                        InfoTableEntry(key: 'Location', value: 'unknown'),
                      ]),
                      SizedBox(width: 50),
                      InfoTable([
                        InfoTableEntry(key: 'Age', value: 'unknown'),
                        InfoTableEntry(key: 'Gender', value: 'unknown'),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoTable extends StatelessWidget {
  final List<InfoTableEntry> entries;

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
              .map((value) => Text(value))
              .toList(),
        ),
      ],
    );
  }
}

class InfoTableEntry {
  final String key;
  final String value;

  InfoTableEntry({required this.key, required this.value});
}

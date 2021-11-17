import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_desk/api/patient/patient.dart';
import 'package:registration_desk/widgets/info_table/info_table.dart';
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
                PatientSummary(widget.patient),
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
  final Patient patient;

  const PatientSummary(this.patient, {Key? key}) : super(key: key);

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
                    patient.name ?? 'unknown',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      InfoTable([
                        Info(
                          key: 'Father\'s name',
                          value: patient.fatherName ?? 'unknown',
                        ),
                        Info(
                          key: 'Location',
                          value: patient.location ?? 'unknown',
                        ),
                      ]),
                      const SizedBox(width: 50),
                      InfoTable([
                        Info(key: 'Age', value: 'unknown'),
                        Info(
                          key: 'Gender',
                          value: patient.gender ?? 'unknown',
                        ),
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


import 'package:flutter/material.dart';
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

  @override
  void initState() {
    tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: widget.tabSelectionBloc.state,
    );
    tabController.addListener(_triggerTabSelectionEvent);
    selectedTab = widget.tabSelectionBloc.state;
    _triggerTabSelectionEvent();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.grey[200],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PatientSummary(),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints.loose(Size(1200, 50)),
                    child: TabBar(
                      controller: tabController,
                      // indicatorColor: Colors.red,
                      isScrollable: true,
                      tabs: [
                        Tab(
                          child: Text(
                            'General',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Visits',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text("Placeholder for content"),
      ],
    );
  }

  void _triggerTabSelectionEvent() {
    widget.tabSelectionBloc.add(TabSelectionChanged(tabController.index));
  }
}

class SummaryPanelTab {
  final String title;
  final Widget content;

  const SummaryPanelTab({
    required this.title,
    required this.content,
  });
}

class PatientSummary extends StatelessWidget {
  const PatientSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'unknown',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

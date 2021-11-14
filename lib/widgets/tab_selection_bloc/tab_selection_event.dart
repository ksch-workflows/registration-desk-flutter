part of 'tab_selection_bloc.dart';

class TabSelectionChanged extends Equatable {
  final int selectedTab;

  const TabSelectionChanged(this.selectedTab);

  @override
  List<Object> get props => [selectedTab];
}

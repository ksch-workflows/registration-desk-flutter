import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tab_selection_event.dart';

// TODO Unit test for tab selection bloc
class TabSelectionBloc extends Bloc<TabSelectionChanged, int> {
  TabSelectionBloc([int initialTab = 0]) : super(initialTab) {
    on<TabSelectionChanged>((event, emit) {
      emit(event.selectedTab);
    });
  }
}

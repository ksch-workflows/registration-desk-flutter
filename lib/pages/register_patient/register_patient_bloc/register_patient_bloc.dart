import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_patient_event.dart';
part 'register_patient_state.dart';

class RegisterPatientBloc extends Bloc<RegisterPatientEvent, RegisterPatientState> {
  RegisterPatientBloc() : super(RegisterPatientInitial()) {
    on<RegisterPatientEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

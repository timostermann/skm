import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'mode_event.dart';
part 'mode_state.dart';

class ModeBloc extends Bloc<ModeEvent, ModeState> {
  ModeBloc() : super(DragMode()) {
    on<ModeEvent>((event, emit) async {
      if (event is ToggleMode) {
        if (state is DragMode) {
          emit(InputMode());
        } else {
          emit(DragMode());
        }
      }
    });
  }
}

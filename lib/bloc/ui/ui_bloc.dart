import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_template/barrel.dart';

part 'ui_event.dart';

part 'ui_state.dart';

class UiBloc extends Bloc<UiEvent, UiState> {
  UiBloc() : super(UiIdle());

  void resume(UiResumedAction action) => add(UiResumed(action: action));

  void idle() => add(TaskCompleted());

  void enqueue() => add(TaskLaunched());

  @override
  Stream<UiState> mapEventToState(UiEvent event) async* {
    if (event is UiResumed) {
      yield UiResume(event.action);
      yield UiIdle();
    }

    if (event is TaskLaunched) {
      yield TaskRunInProgress();
    }

    if (event is TaskCompleted) {
      yield TaskIdle();
    }
  }
}

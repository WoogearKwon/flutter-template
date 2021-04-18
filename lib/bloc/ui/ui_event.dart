part of 'ui_bloc.dart';

@immutable
abstract class UiEvent {}

class TaskLaunched extends UiEvent {}

class TaskCompleted extends UiEvent {}

class UiResumed extends UiEvent {
  final UiResumedAction action;

  UiResumed({@required this.action});
}
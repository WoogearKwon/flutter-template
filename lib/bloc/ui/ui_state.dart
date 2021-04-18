part of 'ui_bloc.dart';

@immutable
abstract class UiState {}

class UiIdle extends UiState {}

class UiResume extends UiState {
  final UiResumedAction action;

  UiResume(this.action);
}

class TaskIdle extends UiState {}

class TaskRunInProgress extends UiState {}

import 'package:bloc/bloc.dart';

import '../utils/utils.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    Logger.i('onEvent(bloc: $bloc, event: $event)');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    Logger.i('onTransition(bloc: $bloc, transition: $transition)');
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    super.onError(cubit, error, stackTrace);
    Logger.i('onError(bloc: $cubit, error: $error, stackTrace: $stackTrace)');
  }
}
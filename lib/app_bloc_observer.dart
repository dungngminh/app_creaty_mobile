// ignore_for_file: strict_raw_type

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log(
      'onBlocCreate -- ${bloc.runtimeType}',
      name: '${bloc.runtimeType}_CREATE',
    );
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('onAddEvent -- $event', name: '${bloc.runtimeType}_EVENT');
  }

  // @override
  // void onTransition(Bloc bloc, Transition transition) {
  //   super.onTransition(bloc, transition);
  //   logger.i(
  //     'onStateTransition -- ${bloc.runtimeType}\n'
  //     'ADD_EVENT: ${transition.event}\n'
  //     'CURRENT_STATE: ${transition.currentState}\n'
  //     'NEXT_STATE: ${transition.nextState}\n'
  //     'name: ${bloc.runtimeType}_TRANSITION',
  //   );
  // }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log(
      'onError -- ${bloc.runtimeType}, $error',
      name: '${bloc.runtimeType}_ERROR',
    );
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    log(
      'onBlocClose -- ${bloc.runtimeType}',
      name: '${bloc.runtimeType}_CLOSE',
    );
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mediasoup_client_flutter/mediasoup_client_flutter.dart';

part 'producers_event.dart';
part 'producers_state.dart';

class ProducersBloc extends Bloc<ProducersEvent, ProducersState> {
  ProducersBloc() : super(ProducersState());

  @override
  Stream<ProducersState> mapEventToState(
    ProducersEvent event,
  ) async* {
    if (event is ProducerAdd) {
      yield* _mapProducerAddToState(event);
    } else if (event is ProducerRemove) {
      yield* _mapProducerRemoveToState(event);
    } else if (event is ProducerResumed) {
      yield* _mapProducerResumeToState(event);
    } else if (event is ProducerPaused) {
      yield* _mapProducerPausedToState(event);
    }
  }

  Stream<ProducersState> _mapProducerAddToState(ProducerAdd event) async* {
    switch (event.producer.source) {
      case 'mic': {
        yield ProducersState.copy(state, mic: event.producer);
        break;
      }
      case 'webcam': {
        yield ProducersState.copy(state, webcam: event.producer);
        break;
      }
      case 'screen': {
        yield ProducersState.copy(state, screen: event.producer);
        break;
      }
      default: break;
    }
  }

  Stream<ProducersState> _mapProducerRemoveToState(ProducerRemove event) async* {
    switch (event.source) {
      case 'mic': {
        state?.mic?.close?.call();
        yield ProducersState.removeMic(state);
        break;
      }
      case 'webcam': {
        state?.webcam?.close?.call();
        yield ProducersState.removeWebcam(state);
        break;
      }
      case 'screen': {
        state?.screen?.close?.call();
        yield ProducersState.removeScreen(state);
        break;
      }
      default: break;
    }
  }

  Stream<ProducersState> _mapProducerResumeToState(ProducerResumed event) async* {
    switch (event.source) {
      case 'mic': {
        state?.mic?.resume?.call();
        yield ProducersState.copy(state);
        break;
      }
      case 'webcam': {
        state?.webcam?.resume?.call();
        yield ProducersState.copy(state);
        break;
      }
      case 'screen': {
        state?.screen?.resume?.call();
        yield ProducersState.copy(state);
        break;
      }
      default: break;
    }
  }

  Stream<ProducersState> _mapProducerPausedToState(ProducerPaused event) async* {
    switch (event.source) {
      case 'mic': {
        state?.mic?.pause?.call();
        yield ProducersState.copy(state);
        break;
      }
      case 'webcam': {
        state?.webcam?.pause?.call();
        yield ProducersState.copy(state);
        break;
      }
      case 'screen': {
        state?.screen?.pause?.call();
        yield ProducersState.copy(state);
        break;
      }
      default: break;
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'call_event.dart';
import 'call_state.dart';
import '../services/signaling_service.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  final SignalingService _signalingService;

  MediaStream? _localStream;
  MediaStream? _remoteStream;

  CallBloc(this._signalingService) : super(CallIdle()) {
    on<ConnectSignaling>(_onConnectSignaling);
    on<InitiateCall>(_onInitiateCall);
    on<EndCall>(_onEndCall);
    on<LocalStreamUpdated>((event, emit) => _emitActiveState(emit));
    on<RemoteStreamUpdated>((event, emit) => _emitActiveState(emit));

    _signalingService.onLocalStream = (stream) {
      _localStream = stream;
      add(LocalStreamUpdated());
    };

    _signalingService.onRemoteStream = (stream) {
      _remoteStream = stream;
      add(RemoteStreamUpdated());
    };

    _signalingService.onCallEnded = () {
      add(EndCall());
    };
  }

  Future<void> _onConnectSignaling(ConnectSignaling event, Emitter<CallState> emit) async {
    await _signalingService.connect(event.myUserId);
  }

  Future<void> _onInitiateCall(InitiateCall event, Emitter<CallState> emit) async {
    await _signalingService.initiateCall(event.targetUserId);
    // Move to Active immediately for the caller so they see their own face while dialing
    _emitActiveState(emit);
  }

  Future<void> _onEndCall(EndCall event, Emitter<CallState> emit) async {
    _signalingService.endCall();
    _localStream = null;
    _remoteStream = null;
    emit(CallIdle());
  }

  void _emitActiveState(Emitter<CallState> emit) {
    emit(CallActive(localStream: _localStream, remoteStream: _remoteStream));
  }

  @override
  Future<void> close() {
    _signalingService.dispose();
    return super.close();
  }
}

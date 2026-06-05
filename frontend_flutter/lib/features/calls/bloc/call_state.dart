import 'package:equatable/equatable.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

abstract class CallState extends Equatable {
  const CallState();
  
  @override
  List<Object?> get props => [];
}

class CallIdle extends CallState {}

class CallRinging extends CallState {
  final String callerId;
  const CallRinging(this.callerId);

  @override
  List<Object> get props => [callerId];
}

class CallActive extends CallState {
  final MediaStream? localStream;
  final MediaStream? remoteStream;

  const CallActive({this.localStream, this.remoteStream});

  @override
  List<Object?> get props => [localStream?.id, remoteStream?.id];
}

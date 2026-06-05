import 'package:equatable/equatable.dart';

abstract class CallEvent extends Equatable {
  const CallEvent();

  @override
  List<Object> get props => [];
}

class ConnectSignaling extends CallEvent {
  final String myUserId;
  const ConnectSignaling(this.myUserId);

  @override
  List<Object> get props => [myUserId];
}

class InitiateCall extends CallEvent {
  final String targetUserId;
  const InitiateCall(this.targetUserId);

  @override
  List<Object> get props => [targetUserId];
}

class CallReceived extends CallEvent {
  final String callerId;
  const CallReceived(this.callerId);

  @override
  List<Object> get props => [callerId];
}

class AcceptCall extends CallEvent {}

class EndCall extends CallEvent {}

// Internal events to update UI with streams
class LocalStreamUpdated extends CallEvent {}
class RemoteStreamUpdated extends CallEvent {}

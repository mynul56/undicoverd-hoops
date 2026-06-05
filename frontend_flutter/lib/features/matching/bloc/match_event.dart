import 'package:equatable/equatable.dart';

abstract class MatchEvent extends Equatable {
  const MatchEvent();

  @override
  List<Object> get props => [];
}

class LikePlayer extends MatchEvent {
  final String playerId;
  final String coachId;

  const LikePlayer({required this.playerId, required this.coachId});

  @override
  List<Object> get props => [playerId, coachId];
}

class AcknowledgeMatch extends MatchEvent {}

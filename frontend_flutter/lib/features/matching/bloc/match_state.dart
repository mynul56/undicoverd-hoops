import 'package:equatable/equatable.dart';

abstract class MatchState extends Equatable {
  const MatchState();

  @override
  List<Object?> get props => [];
}

class MatchInitial extends MatchState {}

class MatchLoading extends MatchState {}

class PlayerSavedSuccessfully extends MatchState {
  final String playerId;
  const PlayerSavedSuccessfully(this.playerId);

  @override
  List<Object> get props => [playerId];
}

class MutualMatchAchieved extends MatchState {
  final String matchId;
  final String targetPlayerId;
  
  const MutualMatchAchieved({required this.matchId, required this.targetPlayerId});

  @override
  List<Object> get props => [matchId, targetPlayerId];
}

class MatchError extends MatchState {
  final String error;
  const MatchError(this.error);

  @override
  List<Object> get props => [error];
}

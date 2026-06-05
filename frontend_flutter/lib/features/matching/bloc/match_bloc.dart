import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_client.dart';
import 'match_event.dart';
import 'match_state.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  final ApiClient _apiClient;

  MatchBloc(this._apiClient) : super(MatchInitial()) {
    on<LikePlayer>(_onLikePlayer);
    on<AcknowledgeMatch>((event, emit) => emit(MatchInitial()));
  }

  Future<void> _onLikePlayer(LikePlayer event, Emitter<MatchState> emit) async {
    emit(MatchLoading());
    try {
      final response = await _apiClient.dio.post(
        '/matches/like',
        data: {
          'coachId': event.coachId,
          'playerId': event.playerId,
        },
      );

      final data = response.data;
      if (data['message'] == 'Mutual match achieved!') {
        emit(MutualMatchAchieved(
          matchId: data['match']['id'],
          targetPlayerId: event.playerId,
        ));
      } else {
        emit(PlayerSavedSuccessfully(event.playerId));
        // Return to initial so they can swipe again
        emit(MatchInitial());
      }
    } catch (e) {
      emit(MatchError(e.toString()));
    }
  }
}

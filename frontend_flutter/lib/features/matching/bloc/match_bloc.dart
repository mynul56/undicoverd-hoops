import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_client.dart';
import 'match_event.dart';
import 'match_state.dart';
import '../../../core/config/config.dart';
import '../../../core/utils/demo_data.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  final ApiClient _apiClient;

  MatchBloc(this._apiClient) : super(MatchInitial()) {
    on<LikePlayer>(_onLikePlayer);
    on<AcknowledgeMatch>((event, emit) => emit(MatchInitial()));
  }

  Future<void> _onLikePlayer(LikePlayer event, Emitter<MatchState> emit) async {
    emit(MatchLoading());
    try {
      dynamic data;
      if (AppConfig.isDemoMode) {
        await Future.delayed(const Duration(milliseconds: 500));
        // Hardcode demo match if it's player 1
        if (event.playerId == 'demo_player_1') {
          data = DemoData.demoMatchResponse;
        } else {
          data = DemoData.demoSaveResponse;
        }
      } else {
        final response = await _apiClient.dio.post(
          '/matches/like',
          data: {
            'coachId': event.coachId,
            'playerId': event.playerId,
          },
        );
        data = response.data;
      }

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

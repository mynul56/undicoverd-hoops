import 'package:flutter_bloc/flutter_bloc.dart';
import 'reels_event.dart';
import 'reels_state.dart';
import '../models/reel_model.dart';

class ReelsBloc extends Bloc<ReelsEvent, ReelsState> {
  ReelsBloc() : super(ReelsInitial()) {
    on<LoadReelsEvent>(_onLoadReels);
  }

  Future<void> _onLoadReels(LoadReelsEvent event, Emitter<ReelsState> emit) async {
    emit(ReelsLoading());
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock Data (Using public sample MP4s for now)
      final mockReels = [
        ReelModel(
          id: '1',
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
          playerFirstName: 'Marcus',
          playerLastName: 'Johnson',
          height: '6\'4"',
          position: 'Point Guard',
          viewCount: 1400,
        ),
        ReelModel(
          id: '2',
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
          playerFirstName: 'David',
          playerLastName: 'Smith',
          height: '6\'8"',
          position: 'Power Forward',
          viewCount: 890,
        ),
        ReelModel(
          id: '3',
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
          playerFirstName: 'Chris',
          playerLastName: 'Williams',
          height: '6\'1"',
          position: 'Shooting Guard',
          viewCount: 3200,
        ),
      ];

      emit(ReelsLoaded(mockReels));
    } catch (e) {
      emit(ReelsError(e.toString()));
    }
  }
}

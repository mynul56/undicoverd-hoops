import 'package:flutter_bloc/flutter_bloc.dart';
import 'reels_event.dart';
import 'reels_state.dart';
import '../models/reel_model.dart';
import '../../../core/config/config.dart';
import '../../../core/utils/demo_data.dart';

class ReelsBloc extends Bloc<ReelsEvent, ReelsState> {
  ReelsBloc() : super(ReelsInitial()) {
    on<LoadReelsEvent>(_onLoadReels);
  }

  Future<void> _onLoadReels(LoadReelsEvent event, Emitter<ReelsState> emit) async {
    emit(ReelsLoading());
    try {
      // Simulate network delay for skeleton loading
      await Future.delayed(const Duration(milliseconds: 1500));

      if (AppConfig.isDemoMode) {
        emit(ReelsLoaded(DemoData.demoReels));
      } else {
        // Fallback or API call
        emit(ReelsLoaded(DemoData.demoReels));
      }
    } catch (e) {
      emit(ReelsError(e.toString()));
    }
  }
}

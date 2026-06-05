import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/reels_bloc.dart';
import '../bloc/reels_event.dart';
import '../bloc/reels_state.dart';
import 'widgets/reel_video_player.dart';
import 'widgets/reel_overlay.dart';

class ReelsFeedScreen extends StatefulWidget {
  const ReelsFeedScreen({super.key});

  @override
  State<ReelsFeedScreen> createState() => _ReelsFeedScreenState();
}

class _ReelsFeedScreenState extends State<ReelsFeedScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Dispatch event to load reels as soon as the screen initializes
    context.read<ReelsBloc>().add(LoadReelsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<ReelsBloc, ReelsState>(
        builder: (context, state) {
          if (state is ReelsLoading || state is ReelsInitial) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          } else if (state is ReelsError) {
            return Center(
              child: Text(
                'Failed to load reels: ${state.message}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else if (state is ReelsLoaded) {
            final reels = state.reels;
            if (reels.isEmpty) {
              return const Center(child: Text('No talent found.', style: TextStyle(color: Colors.white)));
            }

            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: reels.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final reel = reels[index];
                return Stack(
                  children: [
                    ReelVideoPlayer(
                      videoUrl: reel.videoUrl,
                      isActive: index == _currentIndex,
                    ),
                    ReelOverlay(reel: reel),
                  ],
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

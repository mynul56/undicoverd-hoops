import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../bloc/reels_bloc.dart';
import '../bloc/reels_event.dart';
import '../bloc/reels_state.dart';
import '../../matching/bloc/match_bloc.dart';
import '../../matching/bloc/match_state.dart';
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
      body: BlocListener<MatchBloc, MatchState>(
        listener: (context, matchState) {
          if (matchState is MutualMatchAchieved) {
            context.push('/match_celebration', extra: {
              'matchId': matchState.matchId,
              'targetPlayerId': matchState.targetPlayerId,
            });
          }
        },
        child: BlocBuilder<ReelsBloc, ReelsState>(
          builder: (context, state) {
            if (state is ReelsLoading || state is ReelsInitial) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade900,
                highlightColor: Colors.grey.shade800,
                child: Container(
                  color: Colors.black,
                  child: Stack(
                    children: [
                      // Simulated video layout
                      Positioned(
                        bottom: 20,
                        left: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(width: 150, height: 20, color: Colors.white),
                            const SizedBox(height: 10),
                            Container(width: 100, height: 16, color: Colors.white),
                            const SizedBox(height: 10),
                            Container(width: 200, height: 16, color: Colors.white),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 10,
                        child: Column(
                          children: [
                            Container(width: 40, height: 40, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                            const SizedBox(height: 20),
                            Container(width: 40, height: 40, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                            const SizedBox(height: 20),
                            Container(width: 40, height: 40, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
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
      ),
    );
  }
}

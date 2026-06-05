import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../calls/bloc/call_bloc.dart';
import '../../../calls/bloc/call_event.dart';
import '../../../matching/bloc/match_bloc.dart';
import '../../../matching/bloc/match_event.dart';
import '../../models/reel_model.dart';

class ReelOverlay extends StatelessWidget {
  final ReelModel reel;

  const ReelOverlay({super.key, required this.reel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.black.withValues(alpha: 0.7),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.6, 1.0],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${reel.playerFirstName} ${reel.playerLastName}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildStatBadge(Icons.height, reel.height),
                        const SizedBox(width: 8),
                        _buildStatBadge(Icons.sports_basketball, reel.position),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildActionButton(
                    icon: Icons.favorite_border,
                    label: 'Like',
                    onTap: () {
                      // Hardcoding demo values for the prototype
                      context.read<MatchBloc>().add(LikePlayer(
                        playerId: reel.id,
                        coachId: 'demo_coach',
                      ));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Player Saved!')),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildActionButton(
                    icon: Icons.chat_bubble_outline,
                    label: 'Message',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Upgrade to Coach Pro to message players')),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildActionButton(
                    icon: Icons.videocam,
                    label: 'Call',
                    onTap: () {
                      context.read<CallBloc>().add(InitiateCall(reel.id));
                      context.push('/call');
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildActionButton(
                    icon: Icons.share,
                    label: 'Share',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBadge(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.1),
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MatchCelebrationScreen extends StatelessWidget {
  final String matchId;
  final String targetPlayerId;

  const MatchCelebrationScreen({
    super.key,
    required this.matchId,
    required this.targetPlayerId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.9),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "IT'S A MATCH!",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 42,
                fontWeight: FontWeight.w900,
                color: Color(0xFFE4FF00), // Vibrant neon green/yellow
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "You and this player liked each other.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 60),
            
            // Placeholder for the two profile avatars side-by-side
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade800,
                  child: const Icon(Icons.person, size: 50, color: Colors.white),
                ),
                const SizedBox(width: 20),
                const Icon(Icons.favorite, color: Colors.redAccent, size: 40),
                const SizedBox(width: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade800,
                  child: const Icon(Icons.sports_basketball, size: 50, color: Colors.white),
                ),
              ],
            ),

            const SizedBox(height: 80),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE4FF00),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                // Navigate to Chat
                context.pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Chat messaging coming in Sprint 6')),
                );
              },
              child: const Text('Send a Message', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Keep Discovering', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

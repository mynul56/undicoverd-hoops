import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Jalen Green', style: TextStyle(fontWeight: FontWeight.bold)),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Color(0xFF1A1D24)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: const Center(child: Icon(Icons.person, size: 80, color: Colors.white24)),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatBlock(title: 'Height', value: '6\'5"'),
                    _StatBlock(title: 'Position', value: 'SG'),
                    _StatBlock(title: 'Views', value: '14.2K'),
                  ],
                ),
              ),
              const Divider(color: Colors.white24),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Highlight Reels', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              // Fake grid of reels
              GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 9 / 16,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.play_arrow, color: Colors.white54),
                  );
                },
              ),
              const SizedBox(height: 100),
            ]),
          ),
        ],
      ),
    );
  }
}

class _StatBlock extends StatelessWidget {
  final String title;
  final String value;
  const _StatBlock({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.white54)),
      ],
    );
  }
}
